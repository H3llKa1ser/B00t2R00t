# Wordlists

### 1) Directory discovery

    /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

### 2) File discovery

    /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt
    /usr/share/seclists/Discovery/Web-Content/quickhits.txt
    /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-big.txt

### 3) SecLists directory

    /usr/share/seclists/Discovery/Web-Content/common.txt

### 4) SecLists file

    /usr/share/seclists/Discovery/Web-Content/big.txt
    /usr/share/wordlists/seclists/Discovery/Web-Content/raft-large-files.txt

### 5) Custom Wordlist

Get the website content

    curl http://example.com > example.txt

Remove duplicate entries

Create the dictionary

    html2dic example.txt

#### Alternate usage: Cewl

    cewl -w createWordlist.txt https://www.example.com

Improve the wordlist with rules

    john ---wordlist=wordlist.txt --rules --stdout > wordlist-modified.txt

### 6) LFI Wordlist Linux

    /usr/share/seclists/Discovery/Web-Content/default-web-root-directory-linux.txt

### 7) LFI Wordlist Windows

    /usr/share/seclists/Discovery/Web-Content/default-web-root-directory-windows.txt

### 8) General LFI wordlist

    /usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt
    /usr/share/seclists/Fuzzing/LFI/LFI-etc-files-of-all-linux-packages.txt
