# Exploiting the Disk Export and Snapshot Export features

### Like on-premises VMs, Azure VMs have virtual disks attached to them for data storage. At a minimum, an Azure VM has an operating system disk attached to it, but it can also have additional data disks attached to it. These disks can contain useful information that a pentester can leverage at a later attack stage.

### The Azure platform has a feature called Disk Export that can be used to generate a temporary public Shared Access Signature (SAS) URL to download a VM disk. The purpose of this feature is to make it easier for administrators and developers to copy their disks from one Azure region to another, for situations such as disaster recovery. This feature can also be exploited by an attacker to exfiltrate data outside an organization!

## Usage:

 - From the Azure Portal, go to the "Disks" blade in Azure, select a disk, click on the "Disk Export" option and then click on the "Generate URL" button

## NOTE: Disk Export feature can only be used for disks that are not attached to running VMs. If the disk is attached to a running VM, we can first create a snapshot of the disk, and then use the similar Snapshot export feature to generate a temporary SAS URL that we can use to download the snapshot from the internet.

## IMPORTANT NOTE: When downloading a VHD file, keep in mind the size of the file. Typical HTTP web downloads from the Azure portal may struggle with large disks. Additionally, you may want to use an Azure VM, with sufficient disk space, for copying the VHD file. By using the Azure backplane network to copy to a VM disk, you may save significant time in the download process.

### If the disks are encrypted with custom-managed keys, you will need to get the key from the key vault to decrypt it.
