# Teamcity server compromise

## Default port: 8111

## Default credentials: admin:admin teamcity:admin 

# Techniques

## Super User login mode

### TeamCity has a Super User login mode that allows accessing the server UI with System Administrator permissions. This is useful if the administrator forgot their credentials or needs to fix authentication-related settings. The authentication token is automatically generated on every server start and is printed in the file teamcity-server.log. The Super User login is enabled by default

### Command to run if we have the privileges to do so:

 - sudo /usr/bin/cat /opt/JetBrains/TeamCity/logs/teamcity-server.log | grep -i token (Check the logs for a token that we can use as a password. No username.)
