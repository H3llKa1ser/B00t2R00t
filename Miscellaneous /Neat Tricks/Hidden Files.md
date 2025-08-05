# Hidden Files

### Check for hidden files/directories in both Linux and Windows with these commands:

#### 1) 

    dir -force (Windows)

#### 2) 

    ls -la (Linux)

#### 3) Check if files have Alternate Data Streams hidden inside them

    dir /r 
    
#### 4) 

    more < FILE.TXT:ADS_DATA.TXT
