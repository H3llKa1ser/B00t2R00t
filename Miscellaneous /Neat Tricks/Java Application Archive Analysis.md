# Java Application Archive Analysis

## Steps:

 - unzip -d /tmp/APP JAVA_APP.jar

### Check for a file named: application.properties

## Explanation:

### application.properties is a configuration file used in Spring Boot applications. It is typically used to define various properties that configure the behaviour of the application; the properties include database connection settings, logging configurations, and various other settings that the application needs.

 - cat /tmp/app/BOOT-INF/classes/application.properties (Check for sensitive information, like database credentials, etc)
