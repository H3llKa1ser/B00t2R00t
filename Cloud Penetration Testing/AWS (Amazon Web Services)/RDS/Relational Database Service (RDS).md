# AWS Relational Database Service (RDS)

### Amazon Relational Database Service (RDS) is a managed database service provided by Amazon Web Services (AWS) that makes it easy to set up, operate, and scale relational databases in the cloud. RDS automates common administrative tasks such as provisioning, patching, backup, recovery, and scaling, allowing you to focus on building applications rather than managing database infrastructure.

### Key features of Amazon RDS include:

1. **Managed Database Engines**: RDS supports several popular relational database engines, including MySQL, PostgreSQL, MariaDB, Oracle Database, Microsoft SQL Server, and Amazon Aurora (a MySQL and PostgreSQL-compatible database engine developed by AWS). You can choose the database engine that best fits your application requirements and migration needs.

2. **Automated Provisioning and Patching**: RDS simplifies the process of provisioning and managing database instances. With a few clicks or API calls, you can launch a new database instance with the desired configuration, including instance type, storage size, and database engine version. RDS also automates patching and updates, ensuring that your databases are up-to-date with the latest security patches and bug fixes.

3. **High Availability and Reliability**: RDS provides built-in high availability and fault tolerance features to ensure the reliability of your databases. Multi-AZ deployments use synchronous replication to maintain a standby replica in a different Availability Zone, enabling automatic failover in case of a primary instance failure. Amazon Aurora offers even higher availability and durability with a distributed, fault-tolerant storage layer.

4. **Automated Backups and Point-in-Time Recovery**: RDS automatically backs up your databases and transaction logs, allowing you to restore to any point in time within your backup retention period. This enables you to recover from accidental data loss, corruption, or user errors without requiring manual backups or complex recovery procedures.

5. **Scalability and Performance**: RDS allows you to scale your database instances vertically (by changing the instance type) or horizontally (by adding read replicas). You can also enable Auto Scaling to automatically adjust the compute capacity of your database instances based on CPU utilization or other metrics, ensuring optimal performance and cost efficiency.

6. **Security and Compliance**: RDS provides robust security features to protect your databases and data, including encryption at rest and in transit, network isolation using Amazon VPC, IAM integration for authentication and authorization, and database activity logging with Amazon CloudWatch and AWS CloudTrail. RDS is compliant with various industry standards and regulations, such as HIPAA, PCI DSS, and GDPR.

### Overall, Amazon RDS simplifies the process of deploying and managing relational databases in the cloud, allowing you to focus on building scalable, secure, and reliable applications. It is a popular choice for organizations looking to migrate their on-premises databases to the cloud or build new applications with managed database services.

### In simpler terms:

 - Service to use, operate and scale relational databases in AWS (MariaDB, MySQL and similar)

 - The access is done by using password, password+IAM or password+kerberos

 - It's possible to restrict access using restriction such as specific EC2 or lambda or use network level restriction such as vpc, ip.

 - RDS Proxy hadles the traffic between the application and the database, it enables the enforcing of IAM permissions and use secrets manager to store credentials.
