# Ruby YAML Deserialization

## Requirements:

### 1) User can run a ruby script as root

### 2) Input is user-controlled (relative path, permissions to write the malicious file, etc.)

## STEPS

 - sudo /usr/bin/ruby /path/to/program.rb (Run the vulnerable program)

 - ls -la /path/to/program.rb (Check your permissions on the file)

 - cat /opath/to/program.rb (Check the code)

 - Check which file does the program try to load. Use the name and/or absolute path of the named file the program uses to insert your malicious code

 - ruby -v (Check for version of ruby)

 - nano malicious.yml (Insert malicious code here. Link for payloads depending on version: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Insecure%20Deserialization/Ruby.md)

 - sudo /usr/bin/ruby /path/to/program.rb (VOILA!)
