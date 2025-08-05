# HASHCAT

### Usage:

#### -a = Attack type

#### -m = Hash mode https://hashcat.net/wiki/doku.php?id=example_hashes

    hashcat -a 1 -m HASH_TYPE HASH_FILE WORDLIST1 WORDLIST2 = Combination Attack

    hashcat -a 3 -m 0 HASH_FILE -1 01 'ILFREIGHT?l?l?l?l?l20?1?d' = Sample mask attack

