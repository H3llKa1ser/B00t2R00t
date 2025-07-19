# Teamcity server compromise

## Default port: 8111

## Default credentials: admin:admin teamcity:admin 

# Techniques

## Super User login mode

### TeamCity has a Super User login mode that allows accessing the server UI with System Administrator permissions. This is useful if the administrator forgot their credentials or needs to fix authentication-related settings. The authentication token is automatically generated on every server start and is printed in the file teamcity-server.log. The Super User login is enabled by default

### Example command to run if we have the privileges to read the teamcity-server.log:

 - sudo /usr/bin/cat /opt/JetBrains/TeamCity/logs/teamcity-server.log | grep -i token (Check the logs for a token that we can use as a password. No username.)

# Teamcity server foothold

###  It allows us to get a foothold on the underlying server as there's an active agent installed

## Steps

### First, return to General Settings and click Create build configuration . On the Create Build Configuration page, click Manually, input a build name and then click Create .

### On the New VCS Root page click Skip . Then click Build Steps and Add build step . Click the Command Line option and input a build step name. We can enter a test command such as id in the Custom script section to find out our execution context. Although we might expect the server to be running as the teamcity user (as JetBrains recommend), sometimes processes are given elevated privileges to resolve permissions issues.

### After clicking Save and then Run and checking the build log, we see that the server is running as root (example)!

## Commands to use:

 - 1) chmod u+s /bin/bash
 
 - 2) usermod -aG sudo USER (Adds the user to sudo group)

### Then on our target machine if we have SSH access 

 - 2) sudo -s (Gain root shell)

## Alternate method: Agent

### 1) Click on Agents

### 2) Click on the Default Agent -> Open Terminal

### 3) Terminal opened as root (VOILA!)

# Teamcity server secrets decryption

### All TeamCity encrypted secrets start with zxx.

### TeamCity secrets are stored within the data directory.

### Command to find secrets within data directory (Go to: Server Administration -> Global Settings)

 - grep -R zxx

### Then decrypt with the tool: https://github.com/0xE2/teamcity-unscrambler/

 - python3 unscrambler.py TEAMCITY_SECRET

