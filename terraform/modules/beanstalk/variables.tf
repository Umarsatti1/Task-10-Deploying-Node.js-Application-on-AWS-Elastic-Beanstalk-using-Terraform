# Input Variables
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
    type = string
}

variable "monitoring_interval" {
    type = string
}

variable "alert_email" {
    type = string
}

# Reference Variabes
variable "eb_service_role" {
    type = string
}

variable "ec2_instance_profile" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnets" {
    type = list(string)
}

variable "private_subnets" {
    type = list(string)
}

variable "ec2_sg_id" {
    type = string
}