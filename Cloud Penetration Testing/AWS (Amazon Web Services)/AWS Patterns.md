# AWS Patterns

### Service --> URL

#### 1) s3 --> https://{user_provided}.s3.amazonaws.com

#### 2) cloudfront --> https://{random_id}.cloudfront.net

#### 3) ec2 --> ec2-{ip-seperated}.compute-1.amazonaws.com

#### 4) es --> https://{user_provided}-{random_id}.{region}.es.amazonaws.com

#### 5) elb --> http://{user_provided}-{random_id}.{region}.elb.amazonaws.com:80/443

#### 6) elbv2 --> https://{user_provided}-{random_id}.{region}.elb.amazonaws.com

#### 7) rds --> mysql://{user_provided}.{random_id}.{region}.rds.amazonaws.com:3306

#### 8) rds --> postgres://{user_provided}.{random_id}.{region}.rds.amazonaws.com:5432

#### 9) route 53 --> {user_provided}

#### 10) execute-api --> https://{random_id}.execute-api.{region}.amazonaws.com/{user_provided}

#### 11) cloudsearch --> https://doc-{user_provided}-{random_id}.{region}.cloudsearch.amazonaws.com

#### 12) transfer --> sftp://s-{random_id}.server.transfer.{region}.amazonaws.com

#### 13) iot --> mqtt://{random_id}.iot.{region}.amazonaws.com:8883

#### 14) iot --> https://{random_id}.iot.{region}.amazonaws.com:8443

#### 15) iot --> https://{random_id}.iot.{region}.amazonaws.com:443

#### 16) mq --> https://b-{random_id}-{1,2}.mq.{region}.amazonaws.com:8162

#### 17) mq --> ssl://b-{random_id}-{1,2}.mq.{region}.amazonaws.com:61617

#### 18) kafka --> b-{1,2,3,4}.{user_provided}.{random_id}.c{1,2}.kafka.{region}.amazonaws.com

#### 19) kafka --> {user_provided}.{random_id}.c{1,2}.kafka.useast-1.amazonaws.com

#### 20) cloud9 --> https://{random_id}.vfs.cloud9.{region}.amazonaws.com

#### 21) mediastore --> https://{random_id}.data.mediastore.{region}.amazonaws.com

#### 22) kinesisvideo --> https://{random_id}.kinesisvideo.{region}.amazonaws.com

#### 23) mediaconvert --> https://{random_id}.mediaconvert.{region}.amazonaws.com

#### 24) mediapackage --> https://{random_id}.mediapackage.{region}.amazonaws.com/in/v1/{random_id}/channel
