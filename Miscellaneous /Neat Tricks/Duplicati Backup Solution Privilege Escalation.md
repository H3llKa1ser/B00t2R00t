# Duplicati Privilege Escalation

## STEPS:

### 1) Create Backup and Extract Files:

 - On the target machine, create two directories, e.g., dest and result, within our compromised user's folder.

 - In Duplicati, create a new backup task with any name and description, and ensure no encryption is set.

 - Set the destination folder to /source/home/USER/dest and the target to /source/root/root.txt.

 - After creating the task, refresh the Duplicati home page if needed to see the new backup task, then run it.

 - Check /home/USER/dest for .zip files on the machine.

### 2) Restore the Backup:

In Duplicati, select the backup to restore, and set the destination to /source/home/USER/result.

After the restore, check /home/USER/result on the target machine, where you should find root.txt.

