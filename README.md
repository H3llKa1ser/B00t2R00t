# 🥾 B00t2R00t

> A comprehensive offensive security knowledge base — from initial foothold to full domain compromise.

**B00t2R00t** is a curated encyclopedia of penetration testing and red teaming techniques, methodologies, tools, and ready-to-use scripts. Spanning **Active Directory, Cloud, Web, Network, Wireless, and Red Team operations**, it's organized around the real attacker kill chain: **Enumerate → Exploit → Escalate → Persist.**

> ⚠️ **Disclaimer:** This material is provided strictly for **authorized security testing, research, and education**. Only use these techniques on systems you own or have **explicit written permission** to test. The author assumes no liability for misuse. Unauthorized access to computer systems is illegal.

<p align="center">
  <img src="https://img.shields.io/badge/Focus-Offensive%20Security-red" alt="Focus">
  <img src="https://img.shields.io/badge/Files-1800%2B-blue" alt="Files">
  <img src="https://img.shields.io/badge/Topics-AD%20%7C%20Cloud%20%7C%20Web%20%7C%20Red%20Team-purple" alt="Topics">
  <img src="https://img.shields.io/badge/PRs-Welcome-brightgreen" alt="PRs">
</p>

---

## 🧭 How to Use This Repo

- **New to a target type?** Start in [`Methodology/`](./Methodology) — it's the high-level playbook for *what to do and in what order*.
- **Need a specific technique?** Jump straight to the relevant domain folder below.
- **Looking for a tool's syntax?** Head to [`Tools/`](./Tools) — usage docs are separated from techniques on purpose.
- **On an engagement?** Use the methodology as your checklist, then drill into the technique pages as needed.

---

## 📚 Table of Contents

| Section | What's Inside |
|---|---|
| 🗺️ [Methodology](#️-methodology) | Step-by-step playbooks for each target type |
| 🏰 [Active Directory](#-active-directory-penetration-testing) | Enumeration, exploitation, Kerberos, ADCS, trusts, persistence |
| ☁️ [Cloud](#️-cloud-penetration-testing) | AWS, Azure, GCP, Kubernetes |
| 🌐 [Web Applications](#-web-application-penetration-testing) | OWASP-style attacks, injection, auth bypasses, WAF evasion |
| 🔌 [Network Services](#-network-penetration-testing) | Protocol-by-protocol attack references |
| 📡 [Wireless](#-wireless-penetration-testing) | WEP/WPA/WPS attacks, sniffing, MITM |
| 🎭 [Red Teaming](#-red-teaming) | Evasion, C2, payloads, phishing, exfiltration |
| ⬆️ [Privilege Escalation](#️-privilege-escalation) | Linux, Windows, and Docker escapes |
| 🔀 [Pivoting](#-pivoting) | Tunneling, port forwarding, lateral movement |
| 🐛 [CVEs](#-cves) | Notable exploits and write-ups |
| 🤖 [AI Pentesting](#-other-domains) | Prompt injection, jailbreaks, model attacks |
| 🛠️ [Tools](#️-tools) | Usage docs for the offensive toolkit |
| 🧩 [Miscellaneous](#-miscellaneous) | File transfers, shells, wordlists, neat tricks |

---

## 🗺️ Methodology

The **playbook layer** — start here to understand the *flow* of an engagement before diving into specific techniques.

- **[Reconnaissance](./Methodology/Reconnaissance.md)** · **[Enumeration](./Methodology/Enumeration.md)** · **[Public Exploit Search](./Methodology/Public%20Exploit%20Search.md)**
- **[Active Directory](./Methodology/Active%20Directory)** — No Creds / One Credential / Valid Credentials paths
- **[Cloud](./Methodology/Cloud)** — AWS, Azure, GCP, Containers
- **[Privilege Escalation](./Methodology/Privilege%20Escalation)** — Linux & Windows
- **[Web Applications](./Methodology/Web%20Applications)** — full web attack workflow
- **[Protocols](./Methodology/Protocols)** — per-service approach (DNS, SMB, SSH, SQL, etc.)
- **[Lateral Movement](./Methodology/Lateral%20Movement.md)** · **[Network Pivoting](./Methodology/Network%20Pivoting.md)** · **[Password Cracking](./Methodology/Password%20Cracking.md)**

---

## 🏰 Active Directory Penetration Testing

The most extensive section — a complete AD attack lifecycle.

| Phase | Topics |
|---|---|
| **Enumeration** | [No Credentials](./Active%20Directory%20Penetration%20Testing/Enumeration/No%20Credentials) · [Valid Credentials](./Active%20Directory%20Penetration%20Testing/Enumeration/Valid%20Credentials) · [Username Only](./Active%20Directory%20Penetration%20Testing/Enumeration/Valid%20Username%20Only) |
| **Exploitation** | [Kerberos](./Active%20Directory%20Penetration%20Testing/Exploitation/Kerberos) · [GPO](./Active%20Directory%20Penetration%20Testing/Exploitation/GPO) · [Known Vulns](./Active%20Directory%20Penetration%20Testing/Exploitation/Known%20Vulnerabilities) · [ACL/ACE](./Active%20Directory%20Penetration%20Testing/Exploitation/ACL%5CACE) |
| **ADCS** | [Certificate Services attacks](./Active%20Directory%20Penetration%20Testing/Active%20Directory%20Certificate%20Services%20(ADCS)) — ESC1–ESC10, theft, persistence, [mindmaps](./Active%20Directory%20Penetration%20Testing/Active%20Directory%20Certificate%20Services%20(ADCS)/Mindmaps) |
| **Kerberos Delegation** | [Unconstrained / Constrained / RBCD](./Active%20Directory%20Penetration%20Testing/Kerberos%20Delegation) |
| **Lateral Movement** | [PtH, PtT, Pass-the-Cert, WinRM, WMI, more](./Active%20Directory%20Penetration%20Testing/Lateral%20Movement) |
| **MITM & Relay** | [NTLM Relay, Responder, coercion attacks](./Active%20Directory%20Penetration%20Testing/MITM%20Listen%20and%20Relay) |
| **Privilege Escalation** | [DACL attacks, dangerous groups, LAPS, more](./Active%20Directory%20Penetration%20Testing/Privilege%20Escalation) |
| **Persistence** | [Golden/Silver/Diamond tickets, DCShadow, Skeleton Key, more](./Active%20Directory%20Penetration%20Testing/Persistence) |
| **Trust Relationships** | [Cross-domain & cross-forest compromise](./Active%20Directory%20Penetration%20Testing/Trust%20Relationship) |
| **Domain Admin Access** | [NTDS dumping, DPAPI backup keys](./Active%20Directory%20Penetration%20Testing/Domain%20Admin%20Access) |
| **Mitigations** | [Defensive guidance & Event IDs](./Active%20Directory%20Penetration%20Testing/Mitigations) |

---

## ☁️ Cloud Penetration Testing

Provider-by-provider attack references, each following enum → exploit → privesc → persistence.

- **[AWS](./Cloud%20Penetration%20Testing/AWS%20(Amazon%20Web%20Services))** — IAM, EC2, S3, Lambda, EKS, RDS, Secrets Manager, and more
- **[Azure](./Cloud%20Penetration%20Testing/Microsoft%20%20Azure)** — Entra ID, managed identities, Key Vaults, app services, abuse paths
- **[Google Cloud (GCP)](./Cloud%20Penetration%20Testing/Google%20Cloud%20Platform%20(GCP))** — IAM fuzzing, metadata SSRF, privilege escalation
- **[Kubernetes](./Cloud%20Penetration%20Testing/Kubernetes)** — cluster recon, node escapes, secrets
- **[Cross-Platform](./Cloud%20Penetration%20Testing/Cross-Platform)** — Cloudfox, Trufflehog, and multi-cloud tooling

---

## 🌐 Web Application Penetration Testing

Comprehensive coverage of [web attacks](./Web%20Application%20Penetration%20Testing):

- **Injection:** [SQLi](./Web%20Application%20Penetration%20Testing/SQL%20Injection%20(SQLi).md) · [Command Injection](./Web%20Application%20Penetration%20Testing/Command%20Injection.md) · [SSTI](./Web%20Application%20Penetration%20Testing/Server%20Side%20Template%20Injection%20(SSTI).md) · [XXE](./Web%20Application%20Penetration%20Testing/XML%20External%20Entity%20(XXE)%20Injection.md) · NoSQL/LDAP/XPath/ORM
- **Client-side:** [XSS](./Web%20Application%20Penetration%20Testing/Cross-Site%20Scripting%20(XSS).md) · [CSRF](./Web%20Application%20Penetration%20Testing/Cross-Site%20Request%20Forgery%20(CSRF).md) · [Prototype Pollution](./Web%20Application%20Penetration%20Testing/Prototype%20Pollution.md)
- **Server-side:** [SSRF](./Web%20Application%20Penetration%20Testing/Server-Side%20Request%20Forgery%20(SSRF).md) · [LFI/RFI](./Web%20Application%20Penetration%20Testing/Local%20File%20Inclusion%20(LFI).md) · [RCE](./Web%20Application%20Penetration%20Testing/Remote%20Code%20Execution%20(RCE).md) · [Deserialization](./Web%20Application%20Penetration%20Testing/Insecure%20Deserialization.md)
- **Auth & Tokens:** [JWT](./Web%20Application%20Penetration%20Testing/Authentication%20Tokens) · OAuth · MFA bypass
- **Bypasses:** [WAF evasion](./Web%20Application%20Penetration%20Testing/Bypass%20Techniques/WAF) · filter bypasses · [403 bypass](./Web%20Application%20Penetration%20Testing/HTTP%20Code%20403%20(Forbidden)%20Bypass.md)
- **Modern:** [HTTP Request Smuggling](./Web%20Application%20Penetration%20Testing/HTTP%202%20Request%20Tunneling.md) · [GraphQL](./Web%20Application%20Penetration%20Testing/GraphQL%20Pentesting.md) · [Browser Desync](./Web%20Application%20Penetration%20Testing/Browser%20Desync.md)

---

## 🔌 Network Penetration Testing

A [protocol-by-protocol attack library](./Network%20Penetration%20Testing) covering: **SMB, LDAP, SSH, FTP, RDP, SNMP, SMTP, MSSQL, MySQL, PostgreSQL, MongoDB, Redis, NFS, RPC, IPMI, VNC, VoIP, Java RMI/JDWP, gRPC, WebDAV**, and more — plus [CI/CD tooling](./Network%20Penetration%20Testing/CI%5CCD%20Tools) and [database navigation](./Network%20Penetration%20Testing/Databases).

---

## 📡 Wireless Penetration Testing

[Full wireless attack coverage](./Wireless%20Penetration%20Testing): WEP cracking, WPA2-PSK, PMKID, WPS PIN/Pixie Dust, deauth & fake-auth, packet injection/sniffing, MITM, DNS spoofing, and traffic decryption.

---

## 🎭 Red Teaming

End-to-end [adversary simulation tradecraft](./Red%20Teaming):

- **[Evasion Techniques](./Red%20Teaming/Evasion%20Techniques)** — AMSI bypass, AV/EDR evasion, and a deep [AV/EDR Architecture](./Red%20Teaming/Evasion%20Techniques/AV%5CEDR%20Architecture) breakdown
- **[Command & Control](./Red%20Teaming/Command%20And%20Control)** · **[Data Exfiltration](./Red%20Teaming/Data%20Exfiltration)** (DNS / ICMP / HTTPS / TCP)
- **[Advanced Techniques](./Red%20Teaming/Advanced%20Techniques)** — process injection, hollowing, HTA/JScript
- **[Payloads](./Red%20Teaming/Payloads)** · **[Stagers](./Red%20Teaming/Stagers)** · **[Shellcode Runners](./Red%20Teaming/Shellcode%20Runners)**
- **[Spearphishing](./Red%20Teaming/Spearfishing%20Attacks)** — macros, OLE/LNK, XLL, device-code phishing
- **[LOLBins](./Red%20Teaming/Living%20of%20the%20Land%20Binaries%20(LOLBINs))** · **[Offensive PowerShell](./Red%20Teaming/Offensive%20Powershell)** · **[Password Attacks](./Red%20Teaming/Password%20Attacks)**

---

## ⬆️ Privilege Escalation

- **[Linux](./Privilege%20Escalation/Linux)** — SUID, capabilities, cron, kernel exploits, sudo abuse, and dozens more
- **[Windows](./Privilege%20Escalation/Windows)** — service misconfigs, potato exploits, DLL hijacking, token abuse, UAC bypass
- **[Docker Escapes](./Privilege%20Escalation/Docker%20Escapes)** — privileged containers, exposed daemons, namespace abuse

---

## 🔀 Pivoting

[Tunneling and lateral movement](./Pivoting): Chisel, Ligolo-ng, SSH tunneling, Proxychains, DNS/HTTP/ICMP tunneling, double pivots, and [ready-to-go scripts](./Pivoting/Scripts%20on%20the%20Go).

---

## 🐛 CVEs

[Curated exploit write-ups](./CVE): Zerologon, noPAC, PrintNightmare, ProxyShell, Certifried, PetitPotam, Log4j, and more.

---

## 🤖 Other Domains

- **[AI Penetration Testing](./Artificial%20Intelligence%20(AI)%20Penetration%20Testing)** — prompt injection, jailbreaking, model inversion, guardrail bypass
- **[Exploit Development](./Exploit%20Development)** — buffer overflows, race conditions, reverse engineering
- **[Data Lake Pentesting](./Data%20Lake%20Penetration%20Testing)** — Hadoop, HDFS, Kerberos keytabs
- **[Bug Bounty Hunting](./Bug%20Bounty%20Hunting)** — recon automation & workflow

---

## 🛠️ Tools

Usage references for the offensive toolkit, grouped by purpose:

- **[Active Directory](./Tools/Active%20Directory)** — Impacket, NetExec, BloodHound, Mimikatz, Rubeus, Responder, Certipy, and more
- **[C2 Frameworks](./Tools/C2%20Frameworks)** — Cobalt Strike (in depth), Sliver, PowerShell Empire
- **[Enumeration](./Tools/Enumeration)** · **[Network Scanners](./Tools/Network%20Scanners)** · **[Fuzzers](./Tools/Fuzzers)**
- **[Password Crackers](./Tools/Password%20Crackers)** — Hashcat, John, Hydra, Medusa
- **[Phishing Campaigns](./Tools/Phishing%20Campaigns)** — Evilginx + phishlets
- **[Web Applications](./Tools/Web%20Applications)** · **[Exploitation Frameworks](./Tools/Exploitation%20Frameworks)** · **[Wireless](./Tools/Wireless)** · **[AV Evasion](./Tools/AV%20Evasion)**

---

## 🧩 Miscellaneous

[Handy operational references](./Miscellaneous): [file transfer methods](./Miscellaneous/File%20Transfer) (Linux & Windows), [reverse shells](./Miscellaneous/Reverse%20Shells), [shell stabilization](./Miscellaneous/Shell%20Stabilization), [credential harvesting](./Miscellaneous/Credential%20Harvesting), [wordlist creation](./Miscellaneous/Wordlist%20Creation), and a big bag of [neat tricks](./Miscellaneous/Neat%20Tricks).

---

## 🤝 Contributing

Contributions, corrections, and additions are welcome! Feel free to open an issue or submit a pull request.

## 📄 License

See [LICENSE.md](./LICENSE.md) for details.

---

<div align="center">

⭐ **If you find this useful, consider starring the repo!** ⭐

*Built and maintained by [H3llKa1ser](https://github.com/H3llKa1ser)*

*For educational and authorized testing purposes only.*

</div>
