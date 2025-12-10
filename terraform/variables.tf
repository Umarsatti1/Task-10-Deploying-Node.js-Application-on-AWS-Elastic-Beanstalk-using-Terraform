# VPC Variables
variable "vpc_cidr" {
    type = string
}

variable "vpc_name" {
    type = string
}

variable "igw_name" {
    type = string
}

variable "eip_domain" {
    type = string
}

variable "public_route" {
    type = string
}

# IAM Variables
variable "eb_service_role" {
    type = string
}

variable "eb_policy" {
    type = string
}

variable "ec2_service_role" {
    type = string
}

variable "ec2_policy" {
    type = string
}

# Elastic Beanstalk Variables
variable "bucket_name" {
    type = string
}

variable "application_name" {
    type = string
}

variable "environment_name" {
    type = string
}

variable "platform" {
    type = string
}

variable "volume_type" {
    type = string
}

variable "volume_size" {
    type = number
}

variable "monitoring_interval" {
    type = string
}

variable "alert_email" {
    type = string
}


