# Ruby YAML Deserialization

## Requirements:

### 1) User can run a ruby script as root

### 2) Input is user-controlled (relative path, permissions to write the malicious file, etc.)

## STEPS

#### 1) Run the vulnerable program

    sudo /usr/bin/ruby /path/to/program.rb 

#### 2) Check your permissions on the file

    ls -la /path/to/program.rb 

#### 3) Check the code

    cat /path/to/program.rb 

#### 4) Check which file does the program try to load. Use the name and/or absolute path of the named file the program uses to insert your malicious code

#### 5) Check for version of ruby

    ruby -v 

#### 6) Insert malicious code here. Link for payloads depending on version: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Insecure%20Deserialization/Ruby.md

    nano malicious.yml 

#### 7) VOILA!

    sudo /usr/bin/ruby /path/to/program.rb 
