# Enumeration

## User Enumeration

Tools: 

1) username-anarchy https://github.com/urbanadventurer/username-anarchy

2) Oh365UserFinder https://github.com/dievus/Oh365UserFinder

### 1) Generate wordlist

    username-anarchy USER NAME -@ @megacorp.com > emails.txt

### 2) Identify valid email addresses

    python3 oh365userfinder.py -r emails.txt

