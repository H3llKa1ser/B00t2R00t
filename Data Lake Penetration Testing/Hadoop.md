## Terminology


#### Cluster - Refers to all the systems that together make the datalake.

#### Node - A single host or computer in the Hadoop cluster.

#### NameNode - A node that is responsible for keeping the directory tree of the Hadoop file system.

#### DataNode - A slave node that stores files according to the instructions of a NameNode.

#### Primary NameNode - The current active node responsible for keeping the directory structure.

#### Secondary NameNode - The backup node which will perform a seamless takeover of the directory structure should the Primary NameNode become unresponsive. There can be more than one Secondary NameNode in a cluster, but only one Primary active at any given time.

#### Master Node - Any node that is executing a Hadoop "management" application such as HDFS Manager or YARN Resource Manager.

#### Slave Node - Any node that runs a Hadoop "worker" application such as HDFS or MapReduce. It should be noted that a single node can be both a Master and Slave node at the same time.

#### Edge Node - Any node that is hosting a Hadoop "user" application such as Zeppelin or Hue. These are applications that users can use to perform processing on the data stored in the datalake.

#### Kerberised - The term given for a datalake that has security enabled through Kerberos.

## Apache Hadoop Services

#### HDFS - Hadoop Distributed File System is the primary storage application for unstructured data such as files

#### Hive - Hive is the primary storage application for structured data. Think of it as a massive database.

#### YARN - Main resource manager application of Hadoop, used to schedule jobs in the cluster

#### MapReduce - Application executor of Hadoop to process vast amounts of data. It consists of a Map procedure, which performs filtering and sorting, and a reduce method, which performs a summary operation.

#### HUE - A user application that provides a GUI for HDFS and Hive.

#### Zookeeper - Provides operational services for the cluster to set the configuration of the cluster in question.

#### Spark - Engine for large-scale data processing.

#### Kafka - A message broker to build pipelines for real-time data processing.

#### Ranger - Used for the configuration of privilege access control over the resources in the datalake.

#### Zeppelin - A web-based notebook application for interactive data analytics.

