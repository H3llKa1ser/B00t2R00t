# Linux passwd file username wordlist creation

    cat /etc/passwd | cut –d ":" –f1 > usernames.txt
