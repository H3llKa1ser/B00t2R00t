# Public DS_Store file

### Tool: https://github.com/Keramas/DS_Walk

### Usage:

Parse the contents of the .DS_Store file

    python3 ds_walk.py --url http://domain.local

Then use Metasploit to scan for more files within the IIS server

1) Launch Metasploit

        msfconsole

2) Use the shortname scanner module

        use auxiliary/http/iis_shortname_scanner

        set RHOSTS TARGET_IP

        exploit

3) Use the URLs found within the .DS_Store file to further scan for more files within IIS by changing the PATH variable in Metasploit

        set PATH /path/73289789267279843
