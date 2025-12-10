# VPC Variables
module "vpc" {
    source       = "./modules/vpc"
    vpc_cidr     = var.vpc_cidr
    vpc_name     = var.vpc_name
    igw_name     = var.igw_name
    eip_domain   = var.eip_domain
    public_route = var.public_route
}

module "iam" {
    source           = "./modules/iam"
    eb_service_role  = var.eb_service_role
    eb_policy        = var.eb_policy
    ec2_service_role = var.ec2_service_role
    ec2_policy       = var.ec2_policy
}

module "beanstalk" {
    source               = "./modules/beanstalk"
    eb_service_role      = module.iam.eb_service_role
    ec2_instance_profile = module.iam.ec2_instance_profile
    vpc_id               = module.vpc.vpc_id
    public_subnets       = module.vpc.public_subnets
    private_subnets      = module.vpc.private_subnets
    ec2_sg_id            = module.vpc.ec2_sg_id
    bucket_name          = var.bucket_name
    application_name     = var.application_name
    environment_name     = var.environment_name
    platform             = var.platform 
    volume_type          = var.volume_type
    volume_size          = var.volume_size
    monitoring_interval  = var.monitoring_interval
    alert_email          = var.alert_email
}

