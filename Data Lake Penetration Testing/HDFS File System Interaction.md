### Concept:

### One key concept to understand is that your current OS user and your cluster user, DOES NOT have to correspond. Through Kerberos, the cluster will believe you are whoever you authenticate as, regardless of your actual OS user.

## HOW TO USE:

### Resource: https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/HDFSCommands.html

### Find the corresponding /bin directory, that the hdfs binary exists within the host

### Since we possibly don't have available OS commands to traverse the HDFS, we use it via the binary:

    ./hdfs dfs -ls / (Example)
