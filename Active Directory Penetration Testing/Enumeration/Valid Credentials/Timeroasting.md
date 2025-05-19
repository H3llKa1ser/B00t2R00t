# Timeroasting

## Github repo: 

1) https://github.com/SecuraBV/Timeroast

2) https://github.com/SecuraBV/Timeroast/blob/main/timeroast.ps1

3) https://github.com/The-Viper-One/Invoke-AuthenticatedTimeRoast

4) https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/timeroasting (Main page)

## Description

Domain-joined computers typically synchronize their clocks using the Network Time Protocol (NTP), with a Domain Controller (DC) acting as the time source. However, traditional NTP lacks authentication, making it vulnerable to man-in-the-middle (MitM) attacks where an adversary could spoof responses and manipulate the client’s system time.

To mitigate this risk, Microsoft implemented a proprietary extension to NTP that introduces cryptographic authentication. When a computer sends an NTP request, it includes its Relative Identifier (RID) in a special extension field. The Domain Controller responds by appending a Message Authentication Code (MAC) to the response, generated using the NTLM (MD4) hash of the computer account's password as the key.

Crucially, the client does not need to authenticate to the DC in order to make this request. It can simply specify any RID, and the DC will look up the corresponding computer account and generate a response using its password hash.

While this design addresses time spoofing concerns, it introduces a significant security side effect: unauthenticated clients can effectively request salted password hashes for any computer account in the domain. In theory, this isn't a concern if all computer passwords are long, random, and machine-generated — but that's not always true in practice.

As a result, this NTP extension can be abused to harvest password-equivalent hashes for offline cracking, particularly targeting computer accounts with weak or misconfigured passwords.

Timeroasting takes advantage of Windows' NTP authentication mechanism, allowing unauthenticated attackers to effectively request a password hash of any computer account by sending an NTP request with that account's RID

## Unauthenticated (Resolve RIDs of any cracked hashes back to their respective computer name)

### Steps:

#### Linux

    sudo ./timeroast.py 10.0.0.42 | tee ntp-hashes.txt

    hashcat -m 31300 ntp-hashes.txt

#### Windows

    . .\timeroast.ps1

## Authenticated

It's clear from the research around Timeroasting why this technique can be an attractive initial access vector, especially in scenarios where no credentials are available. However, performing Timeroasting from an authenticated perspective also has its own distinct advantages.

Firstly, when authenticated, we can resolve RIDs to hostnames automatically. This significantly simplifies attribution — allowing us to map each SNTP hash back to the corresponding computer account in Active Directory.

Secondly, one could argue that Timeroasting from an authenticated context may seem redundant. After all, if our goal is to obtain hashes for computer accounts, we could simply modify tools like Rubeus or Invoke-Kerberoast, which typically filter only for user objects with Service Principal Names (SPNs). With minimal adjustments, these tools could be extended to include computer objects as well. That said, this approach is rarely used in practice, largely because computer accounts typically use long, random, and machine-generated passwords — making them infeasible to crack unless there's a misconfiguration or weak password policy in place (e.g., set during manual provisioning or imaging).

Interestingly, SNTP hashes obtained through Timeroasting can be cracked approximately 10x faster than traditional Kerberos 5 TGS-REP (etype 23) hashes. While this still doesn't make cracking a randomly generated machine password likely, it does significantly improve the odds when weak passwords are involved — particularly in environments with lax onboarding procedures or poor password hygiene.

Lastly, requesting SPNs for all computer accounts in the domain (as done during Kerberoasting) is far noisier from an OPSEC standpoint. While Timeroasting does generate network traffic for each requested system, it's still a relatively obscure technique. As a result, it's more likely to slip under the radar of typical detection pipelines — making it an attractive alternative when stealth is more a priority.

## TLDR

Timeroasting is a solid option for both unauthenticated and authenticated access. Authenticated use allows easier mapping of SNTP hashes to hostnames, but may seem redundant since Kerberoasting can be adapted to target computer accounts. However, SNTP hashes crack 10x faster than Kerberos TGS-REP hashes, improving chances of success against weak passwords. Plus, Timeroasting is stealthier than mass SPN enumeration, making it more OPSEC-friendly and a valuable alternative in red team ops.

Invoke-AuthenticatedTimeRoast can be used to better support timeroasting from an authenticated perspective. 

https://github.com/The-Viper-One/Invoke-AuthenticatedTimeRoast

##### Default Execution

    Invoke-AuthenticatedTimeRoast -DomainController 10.10.10.100

##### Generate wordlist based on computer names

    Invoke-AuthenticatedTimeRoast -DomainController 10.10.10.100 -GenerateWordlist

## Hashcat

### NOTE: In addition to using common wordlists and rule sets, it's important to include a wordlist of all computer names (lowercased, without the trailing $). This helps catch cases where the computer password matches the hostname—a pattern often seen when accounts are created using the net computer command or the "Assign this computer account as a pre-Windows 2000 Computer" option in the GUI.

    hashcat.exe -m 31300 -a 0 -O hashes.txt rockyou.txt --username
        
