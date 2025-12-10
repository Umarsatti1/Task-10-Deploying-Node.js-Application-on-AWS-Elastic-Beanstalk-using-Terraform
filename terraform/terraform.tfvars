# VPC Variables
vpc_cidr     = "172.20.0.0/16"
vpc_name     = "Umarsatti-VPC"
igw_name     = "Umarsatti-IGW"
eip_domain   = "vpc"
public_route = "0.0.0.0/0"

# IAM Variables
eb_service_role  = "ElasticBeanstalk-ServiceRole"
eb_policy        = "ElasticBeanstalk-ServicePolicy"
ec2_service_role = "ElasticBeanstalk-EC2InstanceRole"
ec2_policy       = "ElasticBeanstalk-EC2InstancePolicy"

# Elastic Beanstalk Variables
bucket_name         = "umarsatti-elastic-beanstalk-app-bucket"
application_name    = "simple-nodejs-app"
environment_name    = "nodejs-environment"
platform            = "64bit Amazon Linux 2023 v6.7.0 running Node.js 24"
volume_type         = "gp2"
volume_size         = 10
monitoring_interval = "1 minute"
alert_email         = "umarsatti.15@gmail.com"


