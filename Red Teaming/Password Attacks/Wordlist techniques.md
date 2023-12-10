# COMBINED WORDLISTS

#### 1) cat file.txt file2.txt file3.txt > combined.txt

#### sort combined.txt | uniq -u > cleaned_combined.txt

# CUSTOMIZED WORDLISTS

### Tool: Cewl

#### cewl -w list.txt -d 5 -m 5 http://example.com

# USERNAME WORDLISTS

### Tool: username_generator

### example:

#### 1) echo "John Smith" > users.lst

#### 2) python3 username_generator.py -w users.lst

# KEYSPACE TECHNIQUE 

### Tools: Crunch, CUPP.py 

### Example:

#### crunch 2 2 01234abcd -o crunch.txt

### Crunch options:

### @ = Lowercase alpha characters

### ^ = Special characters including space

### % = Numeric characters

### , = Uppercase alpha characters

#### Example: crunch 6 6 -t pass%% -o crunch.txt
