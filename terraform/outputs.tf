output "vpc_id" {
    value       = module.vpc.vpc_id
    description = "VPC ID"
}

output "Application_URL" {
    value       = module.beanstalk.environment_url
    description = "This is the Elastic Beanstalk application URL"
}

