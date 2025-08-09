# AWS - Mount EBS volume to EC2 Linux

### EBS snapshots are block-level incremental, which means that every snapshot only copies the blocks (or areas) in the volume that had been changed since the last snapshot. To restore your data, you need to create a new EBS volume from one of your EBS snapshots. The new volume will be a duplicate of the initial EBS volume on which the snapshot was taken.

#### 1) Head over to EC2 –> Volumes and create a new volume of your preferred size and type.

#### 2) Select the created volume, right click and select the "attach volume" option.

#### 3) Select the instance from the instance text box as shown below : attach ebs volume

    aws ec2 create-volume –snapshot-id SNAPSHOT_ID --availability-zone ZONE

    aws ec2 attach-volume –-volume-id VOLUME_ID –-instance-id INSTANCE_ID --device DEVICE

#### 4) Now, login to your ec2 instance and list the available disks using the following command :

    lsblk

#### 5) Check if the volume has any data using the following command :

    sudo file -s /dev/xvdf

#### 6) Format the volume to ext4 filesystem using the following command :

    sudo mkfs -t ext4 /dev/xvdf

#### 7) Create a directory of your choice to mount our new ext4 volume. I am using the name “newvolume” :

    sudo mkdir /newvolume

#### 8) Mount the volume to "newvolume" directory using the following command :

    sudo mount /dev/xvdf /newvolume/

#### 9) cd into newvolume directory and check the disk space to confirm the volume mount :

    cd /newvolume; df -h .
