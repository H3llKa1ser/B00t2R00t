# Java Application Archive Analysis (JAR)

## Steps:

#### 1) Unzip Java archive

    unzip -d /tmp/APP JAVA_APP.jar

### 2)  Check for a file named: application.properties

## Explanation:

### application.properties is a configuration file used in Spring Boot applications. It is typically used to define various properties that configure the behaviour of the application; the properties include database connection settings, logging configurations, and various other settings that the application needs.

#### 3) Check for sensitive information, like database credentials, etc

    cat /tmp/app/BOOT-INF/classes/application.properties 

    /opt/panda_search/src/main/java/com/panda_search/htb/panda_search/MainController.java 


## Easier way to analyze a .jar file

    jd-gui cloudhosting-0.0.1.jar

Then go to 

    BOOT-INF -> classes -> application.properties
