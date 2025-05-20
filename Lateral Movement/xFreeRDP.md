# xFreeRDP

Whilst not a direct pivoting technique, using xFreeRDP to share the hosts file system can give the attacker an easy route for moving files across systems to further assist with pivoting

    xfreerdp /v:IP /u:USERNAME /p:PASSWORD +clipboard /dynamic-resolution /drive:/usr/share/windows-resources,share
