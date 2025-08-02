# Rule-based attacks/Hybrid Attacks

### Tools: Hashcat, John the Ripper

### examples:

#### 1) 

    cat /etc/john/john.conf | grep "List.Rules" | cut -d "." -f3 | cut -d ":" -f2 | cut -d "J" -f1 | awk NF

#### 2) 

    john --wordlist=/tmp/wordlist.txt --rules=best64 --stdout | wc -l

# CUSTOM RULES

#### 1) 

    sudo nano /etc/john/john.conf

#### 2) Add rule to end of john.conf file

    [List.Rules:Example-attacks]

    Az"[0-9]" ^[:@#$]

#### 3) 

    echo "examplepass" > /tmp/single.lst

#### 4) 

    john --wordlist=/tmp/single.lst --rules=example-attacks --stdout
