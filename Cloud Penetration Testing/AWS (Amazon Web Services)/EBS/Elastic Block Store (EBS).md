# AWS Elastic Block Store (EBS)

### Amazon Elastic Block Store (EBS) is a block storage service provided by Amazon Web Services (AWS) that allows you to create and attach persistent block storage volumes to EC2 instances. EBS volumes are designed for use cases that require durable and low-latency storage, such as databases, file systems, and application data.

### Key features of Amazon EBS include:

1. **Persistent Block Storage**: EBS provides durable and persistent block storage volumes that persist independently from EC2 instances. You can create, attach, and detach EBS volumes to EC2 instances as needed, and the data on the volumes persists even after the instance is stopped or terminated.

2. **High Performance**: EBS volumes offer low-latency and high-throughput performance, making them suitable for latency-sensitive workloads such as databases and I/O-intensive applications. You can choose from different types of EBS volumes optimized for different performance characteristics, including SSD-backed volumes (gp2, io1, io2) and HDD-backed volumes (st1, sc1).

3. **Scalability**: EBS volumes can be resized dynamically without any downtime, allowing you to scale your storage capacity up or down as your requirements change. You can increase the size of an existing EBS volume or create additional volumes and attach them to your EC2 instances as needed.

4. **Snapshots and Backups**: EBS volumes can be backed up using snapshots, which are point-in-time copies of the volume data stored in Amazon S3. Snapshots are incremental and only capture the changed data since the last snapshot, reducing storage costs and improving backup efficiency. You can use snapshots to create new volumes, restore data, or migrate volumes between regions.

5. **Encryption**: EBS volumes support encryption at rest using AWS Key Management Service (KMS). You can encrypt both new and existing volumes to protect sensitive data and comply with security and compliance requirements. EBS encryption is transparent to applications and does not impact performance.

6. **Integration with AWS Services**: EBS integrates seamlessly with other AWS services, such as EC2, RDS, and EFS. You can use EBS volumes as the primary storage for EC2 instances, attach them to RDS database instances for storing database files, or use them as data volumes for containerized applications running on ECS or EKS.

### Overall, Amazon Elastic Block Store (EBS) provides scalable, high-performance block storage for EC2 instances, enabling you to store and access data reliably in the AWS cloud. It is a fundamental building block of cloud computing on AWS, supporting a wide range of use cases and workloads with its flexibility, durability, and performance.

### In simpler terms:

 - Block storage system used to store persistent data

 - It's possible to attach this drive to EC2 and increase the storage (Like and HD, but scalable).

 - It's possible to create a snapshot (It will be saved on S3) and create a volume from this snapshot.

 - It's possible to attach the snapshot (Backup of BS) to an EC2 instance

 - Snapshots can be used as volumes or AMI's
