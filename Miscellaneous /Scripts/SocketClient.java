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
