# Kerberos Clock Synchronization

### In Kerberos, time is used to ensure that tickets are valid. To achieve this, the clocks of all Kerberos clients and servers in a realm must be synchronized to within a certain tolerance. The default clock skew tolerance in Kerberos is 5 minutes , which means that the difference in time between the clocks of any two Kerberos entities should be no more than 5 minutes.

#### 1) Detect clock skew automatically with nmap

 - $ nmap -sV -sC 10.10.10.10

clock-skew: mean: -1998d09h03m04s, deviation: 4h00m00s, median: -1998d11h03m05s


#### 2) Compute yourself the difference between the clocks

 - nmap -sT 10.10.10.10 -p445 --script smb2-time -vv

#### Fix #1: Modify your clock

 - sudo date -s "14 APR 2015 18:25:16" # Linux

 - net time /domain /set # Windows

#### Fix #2: Fake your clock

 - faketime -f '+8h' date
