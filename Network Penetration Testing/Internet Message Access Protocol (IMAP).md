# Internet Message Access Protocol (IMAP)

Port 143, 993 (IMAPS)

### 1) Nmap scan

    nmap -p 143,993 --script imap-ntlm-info IP

### 2) Identify software version

    openssl s_client -connect IP:993

### 3) Supported Capabilites check

    python3 check_imap.py IP PORT

Python script

    import imaplib
    import sys
    
    def check_imap_capabilities(host, port):
        if port == 993:
            mail = imaplib.IMAP4_SSL(host)
        else:
            mail = imaplib.IMAP4(host)
        
        print(mail.capabilities())
    
    if __name__ == "__main__":
        if len(sys.argv) != 3:
            print("Usage: python3 script.py <host> <port>")
            sys.exit(1)
        
        host = sys.argv[1]
        port = int(sys.argv[2])
        
        check_imap_capabilities(host, port)
