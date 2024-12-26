# JohnTheRipper (JtR)

### Commands

#### --wordlist=/path/to/wordlist.txt /path/to/file.txt

#### --format=FORMAT (Format specific cracking) (raw- for standard hashes)

#### --list=formats (Checks formats on the list)

#### --rules=wordlist.txt (Uses rules to create password variations)

# CRACKING HASHES FROM /ETC/SHADOW

#### unshadow TARGET_PASSWD TARGET_SHADOW > unshadowed.txt

# SINGLE CRACK MODE (Cracks passwords heuristically based solely on username info you fed it)

#### --single USER:HASH

# CUSTOM RULES

### Located in "john.conf" file.

### Essentially, we use regex to create custom rules

#### --rule=RULE PATH/TO/FILE

# ZIP2JOHN (Cracking zip passwords)

#### zip2john OPTIONS ZIP_FILE > OUT_FILE

#### Generates hash from zip file so that John can crack it.

# RAR2JOHN 

### Same philosophy as zip2john

# SSH2JOHN

#### ssh2john ID_RSA > OUTPUT_FILE

## TIP: All 2john converters work the same as those previously mentioned.
