# Attacking WPA3 Wi-Fi Networks

> **Scope & authorization.** This is defensive/educational reference material for authorized wireless security assessments, lab study, and certification prep (e.g. HTB Academy's *Attacking WPA3*, OSWP-style work). Every technique below is only legal against networks you own or have **written permission** to test. Radio-frequency attacks bleed past property lines, so scope and RF boundaries matter as much as IP scope. The tooling referenced (Dragonblood suite, EAPHammer, hostapd-wpe, etc.) was published by its authors for testing and research — not for attacking networks you don't control.

---

## 1. Wi-Fi Protected Access 3 — Overview

WPA3 was announced by the Wi-Fi Alliance in 2018 as the successor to WPA2, which had been the standard for ~14 years and was showing its age (KRACK, offline dictionary attacks on the 4-way handshake, no protection for management frames). WPA3 is not one protocol but a **certification bundle** with three pillars:

| Pillar | Mechanism | Replaces |
|---|---|---|
| **WPA3-Personal** | SAE (Simultaneous Authentication of Equals / "Dragonfly") | WPA2-PSK 4-way handshake auth |
| **WPA3-Enterprise** | 802.1X/EAP, optional 192-bit CNSA suite | WPA2-Enterprise |
| **Enhanced Open** | OWE (Opportunistic Wireless Encryption, RFC 8110) | Open (unencrypted) networks |

### What actually improved
- **Offline dictionary resistance.** In WPA2, capturing one 4-way handshake (or a PMKID) lets an attacker guess the password offline, forever, with no further contact. SAE is a **PAKE** (password-authenticated key exchange): every password guess requires a fresh live exchange with the AP, so brute force becomes online, slow, and detectable.
- **Forward secrecy.** SAE and OWE both derive a fresh session key per association via Diffie-Hellman, so a compromised password can't decrypt previously captured traffic.
- **Protected Management Frames (PMF / 802.11w) mandatory** for WPA3-SAE and OWE. This is what's supposed to kill deauthentication/disassociation spoofing — the classic "knock a client offline" primitive.
- **192-bit security suite** (CNSA) for high-assurance enterprise: GCMP-256, HMAC-SHA-384, EAP-TLS with strong certs.

### Where WPA3 is still soft (the whole point of this document)
1. **Transition/mixed modes.** To stay backward-compatible, APs run WPA3 *and* WPA2 (SAE-PSK transition), or OWE *and* Open (OWE transition). These modes re-introduce the exact attack surfaces WPA3 removed. Most consumer/enterprise APs ship in transition mode **by default.**
2. **OWE doesn't authenticate the AP.** Encryption without authentication ⇒ evil twins still work.
3. **Dragonblood.** Vanhoef & Ronen (2019/2020) showed downgrade attacks, timing/cache side-channels leaking password info, and DoS against SAE itself.
4. **Implementation bugs** in `hostapd`/`wpa_supplicant` and vendor stacks.

### Useful identifiers on the wire
AKM (Authentication and Key Management) suite selectors in the RSN element tell you what a network really supports:

| AKM | Suite selector | Meaning |
|---|---|---|
| PSK | `00-0F-AC:2` | WPA2 personal |
| SAE | `00-0F-AC:8` | WPA3 personal |
| FT-SAE | `00-0F-AC:9` | Fast-transition SAE |
| OWE | `00-0F-AC:18` | Enhanced Open |
| 802.1X (EAP) | `00-0F-AC:1 / :3` | Enterprise |

Seeing **both** `:2` and `:8` in one beacon = SAE transition mode = downgrade candidate.

---

## 2. OWE — Overview

**Opportunistic Wireless Encryption**, defined in **RFC 8110** (March 2017) and certified by the Wi-Fi Alliance as **"Wi-Fi CERTIFIED Enhanced Open,"** solves one specific problem: **open networks (coffee shops, airports, guest Wi-Fi) send everything in cleartext.** OWE gives every client an individually encrypted link **without any password or login.**

### How it works
1. The station still performs ordinary 802.11 **Open System Authentication** (so legacy-looking).
2. During **Association**, the client and AP each place an ephemeral **Diffie-Hellman public key** inside a *Diffie-Hellman Parameter element* (in the RSN portion). This is normally **Elliptic-Curve DH** — group 19 (NIST P-256) is the common default; FFC groups are also allowed.
3. Each side combines its own private value with the peer's public value → identical **shared secret**. From it they derive a **PMK** (and a PMKID) using **HKDF**.
4. The standard **4-way handshake** then runs using that PMK, producing the PTK/GTK that encrypt data with **CCMP/GCMP**.

### The critical property
OWE provides **encryption, not authentication.** It defeats a **passive** eavesdropper (someone just sniffing the air can't decrypt your session, and can't derive your keys because DH is per-session). It does **nothing** against an **active** attacker who stands up their own AP — there's no server identity to verify.

And per **RFC 8110 §6**, an OWE SSID **must be presented to the user exactly like an open network — no lock icon.** The user cannot tell OWE from open, and (per SpecterOps' research) RFC-compliant supplicants actively prevent users from distinguishing encrypted from unencrypted connections. That design decision is the root of every OWE attack below.

---

## 3. OWE Reconnaissance

Goal: identify OWE networks, their BSSIDs/channels, whether they run **OWE transition mode**, and which clients are present.

**Interface setup**
```bash
sudo airmon-ng check kill          # kill NetworkManager/wpa_supplicant conflicts
sudo airmon-ng start wlan0         # -> wlan0mon (monitor mode)
```

**Passive discovery**
```bash
sudo airodump-ng wlan0mon                       # survey all channels
sudo airodump-ng -c 6 --bssid <AP_MAC> -w owe_capture wlan0mon
```
OWE appears with the OWE AKM in the RSN element. In a capture, filter in Wireshark/tshark:
```bash
# Beacon/probe-response frames, then inspect RSN AKM suites
tshark -r owe_capture-01.cap -Y "wlan.fc.type_subtype == 8" -V | grep -i -A3 "auth key management"
# OWE AKM = 00-0f-ac:18 ; RSN present but no PSK/SAE = Enhanced Open
```

**Spotting OWE Transition Mode.** A transition-mode deployment broadcasts **two BSSes**: a *visible open* SSID and a *hidden OWE* SSID, cross-linked by an **OWE Transition Mode element** (a vendor-specific IE carrying the companion BSSID + SSID). So during recon you'll see an "open" network whose beacons contain a vendor IE pointing at a hidden BSSID — that pairing is the tell.

Other recon tools: `iw dev wlan0 scan`, `nmcli dev wifi`, `bettercap` (`wifi.recon on`), and Wireshark for deep IE inspection.

---

## 4. Recreating the OWE Handshake Steps in Python

The value here is **understanding the cryptography** — replicating the ECDH + HKDF that produces the PMK, so you can parse captured OWE exchanges and reason about the protocol. Per RFC 8110, given client DH public key `C`, AP DH public key `A`, the negotiated `group`, and the DH shared secret `z`:

```
prk = HKDF-Extract(C | A | group, z)
PMK = HKDF-Expand(prk, "OWE Key Generation", n)
PMKID = Truncate-128( Hash(C | A) )
```

A minimal, educational reconstruction using `cryptography` (this derives the same PMK both endpoints compute — it's a learning aid, not an attack tool):

```python
from cryptography.hazmat.primitives.asymmetric import ec
from cryptography.hazmat.primitives.kdf.hkdf import HKDFExpand
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.kdf.hkdf import HKDF
import struct

CURVE = ec.SECP256R1()          # group 19 (NIST P-256)
GROUP_ID = 19

def pub_bytes(pubkey):
    # uncompressed/compact X coordinate representation per the curve definition
    nums = pubkey.public_numbers()
    return nums.x.to_bytes(32, "big")

# --- each side generates an ephemeral keypair ---
client_priv = ec.generate_private_key(CURVE)
ap_priv     = ec.generate_private_key(CURVE)
C = client_priv.public_key()    # client DH public key
A = ap_priv.public_key()        # AP DH public key

# --- ECDH: both sides reach the same shared secret z ---
z_client = client_priv.exchange(ec.ECDH(), A)
z_ap     = ap_priv.exchange(ec.ECDH(), C)
assert z_client == z_ap
z = z_client

# --- RFC 8110 key derivation ---
group = struct.pack(">H", GROUP_ID)
salt  = pub_bytes(C) + pub_bytes(A) + group   # C | A | group
# HKDF-Extract(salt, z) then HKDF-Expand(prk, "OWE Key Generation", n)
pmk = HKDF(algorithm=hashes.SHA256(), length=32,
           salt=salt, info=b"OWE Key Generation").derive(z)

# PMKID = Truncate-128( SHA256(C | A) )
d = hashes.Hash(hashes.SHA256()); d.update(pub_bytes(C) + pub_bytes(A))
pmkid = d.finalize()[:16]

print("PMK  :", pmk.hex())
print("PMKID:", pmkid.hex())
```

Once you have the PMK, the 4-way handshake key schedule (PTK = PRF over PMK, ANonce, SNonce, MACs) is identical to WPA2's — the difference is purely how the PMK was *born*. Building this by hand demystifies why a passive attacker fails (they never see `z`, only public keys) and why an **active** attacker succeeds (they simply *become* one endpoint).

---

## 5. OWE Evil Twin Attack

Because OWE never authenticates the AP and looks identical to open Wi-Fi, an attacker can stand up a **rogue OWE AP with the same SSID** and clients happily perform the DH exchange with the *attacker*. The attacker is now one legitimate endpoint of a per-session-encrypted link — i.e. a full man-in-the-middle, with encryption that fools the *victim's* passive neighbors but not the attacker.

**Concept flow**
1. Recon the target OWE SSID/channel.
2. Broadcast a matching OWE AP, ideally with stronger signal / closer position.
3. Clients associate and complete OWE with you.
4. You run DHCP/DNS, a captive portal, DNS spoofing, TLS interception, etc. downstream.

**Tooling.** The canonical tool is **EAPHammer** (Gabriel Ryan / s0lst1c3), which added first-class OWE support out of the SpecterOps "War Never Changes" research:
```bash
./eaphammer -i wlan0 --auth owe --essid CoffeeShopWiFi --captive-portal
```
By default EAPHammer conforms to RFC 8110 and *requires* PMF for OWE; it exposes flags to weaken or disable PMF for testing. You can also build the rogue AP by hand with a patched `hostapd` OWE config plus `dnsmasq` (DHCP/DNS) and a captive portal — the SpecterOps team notably had to reverse-engineer hostap's test suite to get working OWE configs, since none were documented in 2019.

**Why it works even "securely":** the encrypted session is real — it just terminates on the attacker. The lock-less UI means the victim has zero signal that anything is wrong.

---

## 6. OWE Collider Evil Twin Attack

The plain evil twin has a practical hurdle: **existing** clients are already associated to the real AP, and with **PMF** you can't just deauth them over to you. The "**collider**" variant sidesteps deauthentication entirely.

**Idea.** Instead of knocking clients off (blocked by PMF), you run a **competing, colliding AP** on the same SSID and let the client's own **roaming/selection logic** pick you. Clients continuously evaluate candidate BSSes for the same SSID and prefer the one with the best RSSI / fastest, cleanest responses. By:
- broadcasting the same SSID (and often spoofing the BSSID),
- winning on signal strength (proximity, high-gain antenna, higher TX power), and
- responding to probe requests faster than the real AP so your response frames "collide with" and beat the legitimate ones,

new and roaming associations land on the attacker **without a single deauth frame** — which is exactly what you need in a PMF-protected OWE environment. It's an attrition/race strategy rather than a disruption strategy: you don't break the client's current link, you make yourself the more attractive next hop and wait for natural roams and new joins.

This matters specifically for OWE because there's no AP identity to fail — winning the race *is* winning the client.

---

## 7. OWE Transition Mode Evil Twin

**OWE Transition Mode** exists so networks can adopt Enhanced Open without breaking pre-OWE devices. The AP advertises **two co-located BSSes**:
- a **visible "Open" BSS** (real open auth, **unencrypted** — legacy clients use this), and
- a **hidden OWE BSS** (encrypted — OWE-capable clients silently migrate here),

linked by the **OWE Transition Mode element** that names the partner BSSID/SSID.

**Why it's attackable**
- The **companion Open BSS is genuinely unencrypted.** Any legacy client (or any OWE client that fails to migrate) is transmitting in cleartext — an attacker just sniffs, no evil twin required.
- An attacker can spoof the **transition element**, present a matching open BSS, and either capture legacy clients directly or steer OWE clients toward attacker-controlled BSSes.

**Tooling**
```bash
./eaphammer -i wlan0 --auth owe-transition --essid GuestNet --captive-portal
```
EAPHammer's `owe-transition` mode builds the paired open+OWE rogue for you (and again exposes PMF toggles for RFC-violating test cases). The strategic takeaway: **transition mode collapses OWE's guarantees down to "open network with extra steps"** for any device that ends up on the open half.

---

## 8. SAE — Overview

**Simultaneous Authentication of Equals** (the WPA3-Personal handshake), based on the **Dragonfly** PAKE, replaces WPA2's PSK 4-way handshake authentication. Both endpoints prove they know the passphrase **without transmitting anything that enables an offline guess**, and both contribute equally to the key (hence "of equals").

**Two message exchanges**
1. **Commit.** Each side derives a **Password Element (PWE)** — a point on the negotiated group (elliptic curve or MODP) — from the passphrase, then sends a *commit frame* containing a **scalar** and an **element** built from random `rand` and `mask` values plus the PWE.
2. **Confirm.** Using the commit values each side computes a shared secret and sends a *confirm frame* (a hash) proving it derived the same key. Success ⇒ a PMK, which then feeds the normal 4-way handshake → PTK.

**PWE derivation — the security-critical step**
- **Hunting-and-Pecking** (original): iteratively hash the password + counter until you land a valid curve point. Its running time **depends on the password**, which is precisely what leaks in Dragonblood's timing/cache side-channels.
- **Hash-to-Element (H2E)**: a constant-time replacement added specifically to mitigate those side-channels. Modern WPA3 prefers H2E.

**Properties:** mutual authentication, **online-only** password guessing (each guess needs a live exchange), forward secrecy, and **mandatory PMF.**

**Group negotiation** (ECC group 19 / P-256 is the default) is **not cryptographically protected** — the seed of the group-downgrade attack.

---

## 9. SAE Reconnaissance

```bash
sudo airodump-ng wlan0mon                 # SAE shows as WPA3
sudo airodump-ng -c <ch> --bssid <AP> -w sae_cap wlan0mon
```
Confirm SAE and — crucially — whether **transition mode** (SAE + PSK) is on:
```bash
tshark -r sae_cap-01.cap -Y "wlan.fc.type_subtype == 8" -V | grep -i "auth key management"
# Both SAE (00-0f-ac:8) AND PSK (00-0f-ac:2) present => WPA3/WPA2 transition => downgradeable
```
Also inspect **PMF capability bits** (MFPC = capable, MFPR = required) in the RSN Capabilities field. WPA3-SAE-only should show PMF **required**; transition mode typically does **not** require PMF for the WPA2 clients — that's what makes deauth-driven downgrade viable. Capture the **commit/confirm** frames (authentication frames, subtype 11) to study or feed later analysis.

---

## 10. SAE Downgrade Attack

The headline WPA3-Personal weakness, straight out of Dragonblood. Two flavors:

**(a) Transition-mode downgrade (protocol-level).** In SAE/PSK transition mode the AP accepts *both* WPA3-SAE and WPA2-PSK using the **same passphrase**. Because WPA3 **doesn't cryptographically bind the SSID** to the SAE handshake, a client can't distinguish a legit mixed-mode AP from a WPA2-only impostor.

1. Recon confirms transition mode.
2. Stand up a **rogue AP, same SSID, advertising only WPA2-PSK.**
3. Deauth clients off the real AP — transition mode doesn't mandate PMF for WPA2 clients, so **forged deauth frames are accepted.**
4. The victim reconnects via **WPA2**, producing a capturable **4-way handshake**.
5. Crack it **offline** (hashcat/aircrack) — defeating the entire premise of WPA3.

Even without a full rogue AP, an attacker can forge the *first* WPA2 handshake message (unauthenticated); the client's authenticated reply leaks enough for a dictionary attack.

**(b) Group downgrade.** SAE's group negotiation isn't protected, so an attacker (e.g. using ModWifi to block commit frames) can force use of a weaker/older group (MODP 22/23/24, or a curve with side-channel-friendly properties), enabling Dragonblood's timing attacks.

**Mitigation — Transition Disable.** The Wi-Fi Alliance's *Transition Disable* feature lets an AP signal that it fully supports SAE-only; a client that has seen this flag will **stop using transition mode** and refuse WPA2 fallback for that network, closing (a). Where it's not deployed, the network is only as strong as WPA2.

---

## 11. Online Brute-Forcing (SAE)

SAE's design deliberately makes password guessing **online**: each candidate requires a complete commit/confirm exchange **with the real AP**, so there's no "capture once, crack forever." That has hard consequences for attackers:

- **Slow.** One network round-trip (and expensive ECC math) per guess.
- **Detectable & rate-limited.** APs implement **anti-clogging tokens** and lockouts; a flood of failed SAE attempts is noisy and looks like the DoS traffic in §14.
- **Impractical at dictionary scale** against any non-trivial passphrase.

So online brute force is mostly relevant as a *concept* and for very weak passwords. In practice, when SAE resists you, the productive path is **not** to grind SAE online — it's to **downgrade to WPA2 and crack offline** (§10), or use a **social-engineering evil twin** that simply asks the user for the passphrase (§13). Dragonblood's real contribution wasn't faster online guessing — it was **side-channels that turn SAE's online-only guarantee back into an offline password-partitioning attack** (`dragonforce`): leak timing/cache info about the PWE derivation, then partition the dictionary offline. Vanhoef & Ronen estimated brute-forcing a 10¹⁰ dictionary at **under \$1 of EC2**.

---

## 12. SAE Collider Evil Twin Attack

Same "avoid deauth, win the race" philosophy as §6, but SAE adds a hard constraint: **SAE is mutual authentication, so you cannot complete the handshake without the passphrase.** A rogue SAE AP that doesn't know the password can't produce valid confirm frames, so a client won't finish associating to it.

That reshapes what "collider" means for SAE:
- **If you have the passphrase** (from a downgrade+crack, or provided in a sanctioned assessment): the collider approach lets you win associations by out-competing the real AP on signal/timing **without deauth** (needed because SAE mandates PMF). You then run a fully valid SAE rogue (§13) and MITM.
- **If you don't have the passphrase:** a pure SAE evil twin is impossible; the collider/race is combined with **downgrade** (present a colliding WPA2-only BSS in transition-mode networks) or with a **captive-portal credential-phishing** rogue that harvests the passphrase and validates it against the real AP before committing (Fluxion-style).

The honest summary: **SAE's mutual auth is what makes it strong.** "Colliding" gets clients to *prefer* you, but you still need the secret (or a downgrade) to *keep* them.

---

## 13. SAE Evil Twin Attack

Two situations:

**(1) Passphrase known.** Run a legitimate **WPA3-SAE rogue AP** (`hostapd` with `wpa_key_mgmt=SAE`, `ieee80211w=2`, matching SSID). Clients authenticate normally — to you — and you MITM downstream (DHCP, DNS spoofing, SSL interception). Getting clients over still means winning selection without deauth (PMF), so combine with the §12 collider approach or target transition-mode WPA2 clients.

**(2) Passphrase unknown — social-engineering evil twin.** Since you can't fake SAE, you change the game:
- Stand up a rogue (often open) AP with the target SSID and a **captive portal** that impersonates the router/vendor and asks the user to "re-enter the Wi-Fi password."
- Optionally deny service on the real AP (against transition-mode WPA2 clients, or via §14 DoS) so victims are motivated to reconnect through you.
- **Validate** the entered passphrase against the real AP; if wrong, prompt again; if right, you now have the PSK and can spin up a matching SAE AP.

Tools: `hostapd`/`hostapd-mangle`, `wifiphisher`, `airgeddon`, `bettercap`, EAPHammer (portal + rogue AP). PMF is the main obstacle to shepherding existing clients, which is why the passphrase-phishing route is popular against WPA3-Personal.

---

## 14. SAE DoS Attacks

Ironically, SAE's **defenses make it easier to exhaust.** The anti-side-channel and anti-clogging machinery mean each incoming commit frame costs the AP real ECC computation.

**Dragondrain** (Vanhoef) — the reference SAE DoS tool (associated with **CVE-2019-9496** and the resource-exhaustion class):
- Floods the AP with a high volume of **SAE commit frames**.
- The AP performs expensive elliptic-curve operations **per commit**.
- CPU saturates → the AP becomes unresponsive to legitimate clients (auth timeouts, dropped probe responses).

```bash
# Conceptual usage (Dragonblood 'dragondrain-and-time'; Atheros/ath_masker required).
# DoS knocks the AP offline for ALL clients — only ever run against
# infrastructure you're explicitly authorized to disrupt.
sudo ./dragondrain -d wlan0 -a <AP_MAC> -c <channel>
```
Anti-clogging tokens are meant to blunt this but can be bypassed/overwhelmed.

**Other DoS vectors**
- **Deauth/disassoc floods** are largely neutralized on true WPA3-SAE by **PMF** — but still work against **WPA2 clients in transition mode.**
- Management/auth-frame floods, beacon floods, and RF jamming remain protocol-agnostic options (`mdk4`, etc.).
- **Dragontime** (timing) and **Dragonforce** (password partitioning) are analysis/exploitation tools rather than pure DoS, but often paired with the same setup.

DoS is the bluntest tool here and the easiest to cause collateral damage with — treat authorization for it as separate and explicit.

---

## 15. Enterprise Overview & Attacks

**WPA3-Enterprise** uses **802.1X/EAP** with a backend **RADIUS** server. The optional **192-bit CNSA suite** adds GCMP-256, HMAC-SHA-384, EAP-TLS with strong certificates, and mandatory PMF. The security of the whole thing hinges on **how the client validates the RADIUS server.**

### EAP methods, ranked by attackability
| Method | Nature | Attack exposure |
|---|---|---|
| **EAP-TLS** | Mutual cert auth | **Strong.** Client validates the server cert *before* sending anything — a rogue AP/RADIUS can't forge it. Structurally immune to evil twin. |
| **PEAP / EAP-TTLS (MSCHAPv2 inside)** | Tunneled password | **Weak if server cert isn't validated.** The #1 real-world enterprise Wi-Fi flaw. |
| **EAP-PWD** | Dragonfly password | **Dragonblood applies** (CVE-2019-9495 cache side-channel, CVE-2019-9497 reflection, invalid-curve auth bypass). |

### The classic enterprise attack: rogue AP + rogue RADIUS
If clients (or the OS profile / MDM) **don't strictly validate the server certificate**, an attacker impersonates both the AP and the RADIUS server:

```bash
# EAPHammer: stand up an evil-twin AP with a rogue RADIUS to capture creds
./eaphammer --cert-wizard                      # generate a plausible server cert
./eaphammer -i wlan0 --channel 6 --auth wpa-eap --essid CorpWiFi \
            --creds                            # capture challenge/response
```
- The victim's supplicant, seeing a same-SSID AP and an un-validated cert, proceeds with **PEAP-MSCHAPv2**.
- You capture the **MSCHAPv2 challenge/response**, then crack it **offline** — `asleap`, or hashcat `-m 5500`; MSCHAPv2's reliance on DES makes recovery of the NT hash tractable, then the password.
- `hostapd-wpe` (the "Wireless Pwnage Edition" of hostapd) is the classic alternative to EAPHammer for the same rogue-RADIUS credential capture.

### Other enterprise techniques
- **Hostile portal attacks** (EAPHammer): capture creds, then redirect the victim into an attacker-controlled portal for indirect pivots.
- **GTC downgrade**: coax clients into EAP-GTC to grab **cleartext** credentials.
- **Relay / credential theft** and reuse against other services (creds are often domain credentials).
- **EAP-PWD Dragonblood** (`dragonslayer`): invalid-curve attacks bypass authentication when the attacker holds a valid **username**; plus timing/cache side-channels on the Dragonfly PWE derivation.

### Enterprise mitigations
Enforce **server certificate validation** with a **pinned private CA** (this alone kills the PEAP-MSCHAPv2 evil twin); prefer **EAP-TLS**; deploy the **192-bit** suite for high assurance; **disable EAP-PWD**; require PMF; and lock down client profiles via MDM so users can't "trust and continue" past an unknown cert.

---

## Cross-cutting defenses (blue-team summary)
- **Disable transition modes** once your fleet supports WPA3-only / Enhanced-Open-only, and turn on **Transition Disable** signaling. This closes the majority of practical downgrade attacks.
- **Require PMF** everywhere (kills deauth-driven downgrade and most cheap DoS).
- **Prefer H2E** password-element derivation and patch `hostapd`/`wpa_supplicant` and vendor firmware for the Dragonblood CVEs.
- **Enterprise: EAP-TLS + strict server-cert validation + CA pinning.** Never allow un-validated PEAP/TTLS.
- **Strong, high-entropy passphrases** (SAE resists online guessing but not a downgrade+offline crack of a weak WPA2 handshake).
- **WIDS/WIPS** to detect rogue same-SSID APs, deauth storms, and SAE commit floods.
- Consider **SAE-PK** (public-key extension of WPA3-Personal) for shared-password public networks, which binds a public key to the password fingerprint to defeat evil twins.

## Toolbox reference
- **Recon/capture:** aircrack-ng suite (`airmon-ng`, `airodump-ng`, `aireplay-ng`), Wireshark/`tshark`, `bettercap`, `iw`, `hcxdumptool`/`hcxtools`.
- **Rogue AP / evil twin:** `hostapd`, `hostapd-mangle`, `hostapd-wpe`, **EAPHammer**, `wifiphisher`, `airgeddon`, `dnsmasq` (DHCP/DNS).
- **WPA3-specific research tooling:** Dragonblood suite — `dragondrain` (DoS), `dragontime` (timing), `dragonforce` (password partitioning), `dragonslayer` (EAP-pwd) — and `ModWifi` for frame manipulation/downgrade.
- **Cracking:** `hashcat` (`-m 22000` WPA, `-m 5500` NetNTLMv1/MSCHAPv2), `aircrack-ng`, `asleap`.

## Key primary sources
- RFC 8110 — *Opportunistic Wireless Encryption*
- Vanhoef & Ronen — *Dragonblood: Analyzing the Dragonfly Handshake of WPA3 and EAP-pwd* (IEEE S&P 2020); tools at wpa3.mathyvanhoef.com
- Gabriel Ryan (SpecterOps) — *War Never Changes: Attacks Against WPA3's Enhanced Open* (Parts 1–3); EAPHammer
- Wi-Fi Alliance — WPA3 & Enhanced Open specifications; Transition Disable; SAE-PK
