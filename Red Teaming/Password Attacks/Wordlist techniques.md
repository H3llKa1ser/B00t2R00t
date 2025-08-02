# Wordlist Techniques

## COMBINED WORDLISTS

#### 1) 

    cat file.txt file2.txt file3.txt > combined.txt

    sort combined.txt | uniq -u > cleaned_combined.txt

## CUSTOMIZED WORDLISTS

### Tool: Cewl, mentalist, wordlistctl, TTPassGen

#### 

    cewl -w list.txt -d 5 -m 5 http://example.com

### cewl flags: 

#### -d = Depth to spider to (default=2)

#### -w = write to a file

### TTPassGen crafts wordlists from scratch

### Examples:

### 4digits PIN code wordlist:

    ttpassgen --rule '[?d]{4:4:*}' pin.txt

### List of all lowercase chars combinations of length 1 to 3:

    ttpassgen --rule '[?1]{1:3:*}' abc.txt

### Wordlist combination example: (Separated by a dash)

    ttpassgen --dictlist 'pin.txt,abc.txt' --rule '$0[-]{1}$1' combo.txt

# USERNAME WORDLISTS

### Tool: username_generator

### example:

#### 1) 

    echo "John Smith" > users.lst

#### 2) 

    python3 username_generator.py -w users.lst

# KEYSPACE TECHNIQUE 

### Tools: Crunch, CUPP.py 

### Example:

#### 

    crunch 2 2 01234abcd -o crunch.txt

### Crunch options:

### @ = Lowercase alpha characters

### ^ = Special characters including space

### % = Numeric characters

### , = Uppercase alpha characters

#### Example: 

    crunch 6 6 -t pass%% -o crunch.txt

# SEARCH FOR WORDLISTS

#### wordlistctl = Fetches, installs, updates and searches wordlist archives throughout the internet.

#### usage: 

#### search = search specific subject

#### list -g = search from a category

#### -l = Local archives

#### -r = Remote archives
