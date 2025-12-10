output "environment_url" {
    value       = aws_elastic_beanstalk_environment.eb_environment.endpoint_url
    description = "Environment URL"
}

output "sns_topic_arn" {
    value       = aws_sns_topic.alerts.arn
    description = "SNS topic ARN for Beanstalk alerts"
}

output "memory_alarm_arn" {
    value       = aws_cloudwatch_metric_alarm.memory_high.arn
    description = "CloudWatch Memory Alarm ARN"
}