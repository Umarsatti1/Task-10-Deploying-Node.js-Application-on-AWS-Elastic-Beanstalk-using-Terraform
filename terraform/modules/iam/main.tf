# 1. Elastic Beanstalk Service Role

# Trust Relationship
data "aws_iam_policy_document" "eb_service_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
  }
}

# Create the IAM Role
resource "aws_iam_role" "eb_service_role" {
  name               = var.eb_service_role
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eb_service_assume_role.json
}

# Create the IAM Policy
resource "aws_iam_policy" "eb_service_policy" {
  name        = var.eb_policy
  description = "Permissions for the Elastic Beanstalk Service Role (read from JSON file)"
  policy      = file("${path.root}/eb-permissions.json")
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "eb_service_policy_attachment" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = aws_iam_policy.eb_service_policy.arn
}

# 2. Elastic Beanstalk EC2 Role

# Trust Relationship
data "aws_iam_policy_document" "eb_ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Create the IAM Role
resource "aws_iam_role" "eb_ec2_role" {
  name               = var.ec2_service_role
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eb_ec2_assume_role.json
}

# Create the IAM Policy
resource "aws_iam_policy" "eb_ec2_policy" {
  name        = var.ec2_policy
  description = "Permissions for the EC2 Instances created via Elastic Beanstalk"
  policy      = file("${path.root}/instance-permissions.json")
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "eb_ec2_policy_attachment" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = aws_iam_policy.eb_ec2_policy.arn
}

# 3. Create the IAM Instance Profile (Required to assign the role to EC2)
resource "aws_iam_instance_profile" "eb_ec2_instance_profile" {
  name = var.ec2_service_role # Using the same name as the role is common
  role = aws_iam_role.eb_ec2_role.name
}