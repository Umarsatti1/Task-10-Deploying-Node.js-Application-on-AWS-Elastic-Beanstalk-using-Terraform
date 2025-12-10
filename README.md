# Task 10: Deploying a Simple Node.js Application on AWS Elastic Beanstalk using Terraform

---

## Task Description

Deploy a Node.js application to **AWS Elastic Beanstalk** using **Terraform**. The task includes:  

- Creating the Elastic Beanstalk application and environment
- Setting up VPC with Internet gateway, NAT gateways, public/private subnets, and route tables
- Uploading and deploying the application bundle to S3
- Using Load balancer, Auto Scaling group, and Target groups
- Configuring platform settings, scaling, and monitoring
- Setting up CloudWatch alarms for CPU and Memory utilization
- Sending email notifications to SNS
- Validating deployment and application health  

---

## Architecture Diagram

<p align="center">
  <img src="./diagram/Architecture Diagram.png" alt="Architecture Diagram" width="850">
</p>

---

## Task 1: Test Application Locally

Before deploying, the Node.js application is tested locally.

**Files Overview:**

- **app.js** – Main server file using Express. Provides `/health` endpoint and serves static files.  
- **package.json** – Project metadata, Node.js version, dependencies, and scripts.  
- **public/index.html** – Main HTML page styled with Tailwind CSS.  

**Test Steps:**

```bash
npm install
node app.js
```

Verify application at [http://localhost:3000](http://localhost:3000).  

---

## Task 1.2: S3 Bucket for Terraform Remote Backend

Steps to create the bucket:

1. Go to **AWS Console → S3 → Create Bucket**  
2. Select a unique name and region (us-west-1)  
3. Update `terraform.tf` to reference this bucket in the backend  

**Purpose:**  

- Centralized Terraform state  
- State locking to prevent concurrent modifications  

Example path in S3:  
`umarsatti-terraform-state-file-s3-bucket-sandbox/Task-10/terraform.tfstate`  

---

## Task 1.3: Project Structure

Project root directory contains:  

- **.ebextensions/** – Configures CloudWatch Agent on EC2 instances  
- **app.zip** – Node.js application bundle  
- **terraform/** – Terraform configuration (modules for VPC, IAM, Beanstalk)  
- Local files for testing: `app.js`, `package.json`, `public/index.html`  

### .ebextensions

- Contains `cloudwatch.config`  
- Writes CloudWatch Agent configuration to `/opt/aws/amazon-cloudwatch-agent/bin/config.json`  
- Collects memory metrics under namespace `CWAgent`  
- Dynamically appends AutoScalingGroupName dimension  
- Starts CloudWatch Agent via `container_commands`  

### app.zip

- Bundles: `app.js`, `package.json`, `public/index.html`, `.ebextensions/`  
- Uploaded to S3 and deployed by Elastic Beanstalk  

### Terraform Directory Files

**main.tf** – Orchestrates modules (VPC, IAM, Elastic Beanstalk)  
**terraform.tf** – AWS provider + S3 backend configuration  
**variables.tf** – Input variables for all modules  
**terraform.tfvars** – Environment-specific values  
**outputs.tf** – Key outputs (VPC ID, EB URL)  
**eb-permissions.json / instance-permissions.json** – IAM policies  

**Modules:**  

- **VPC Module:** Creates VPC, subnets, IGW, NAT gateways, route tables, security groups  
- **IAM Module:** Creates EB service role, EC2 instance role, IAM instance profile  
- **Elastic Beanstalk Module:** Uploads `app.zip` to S3, creates EB application, environment, ALB, auto scaling, CloudWatch alarms, and notifications  

---

## Task 1.4: Execute Terraform Commands

```bash
terraform init       # Initialize Terraform
terraform validate   # Validate configuration
terraform plan       # Show execution plan
terraform apply --auto-approve  # Deploy infrastructure
```

Resources deployed: VPC, subnets, SGs, IAM roles, S3 bucket, EB app & environment, ALB, scaling policies, CloudWatch alarms, SNS notifications.  

---

## Task 1.5: Validate Infrastructure in AWS Console

**1.5.1 VPC & Networking** – Verify VPC, subnets, IGW, NAT, route tables, and security groups  

**1.5.2 IAM** – Validate EB service role, EC2 instance role, and instance profile  

**1.5.3 Elastic Beanstalk** – Verify application and environment creation  

**1.5.4 EC2, ALB, Target Groups, ASG** – Confirm instances, load balancer, target groups, and auto scaling group  

**1.5.5 S3** – Confirm `app.zip` uploaded to bucket  

**1.5.6 SNS** – Validate topics and email subscriptions  

**1.5.7 CloudWatch** – Confirm log groups and alarms for CPU and memory  

---

## Task 1.6: Application Testing, Alarm Verification, and Auto Scaling

**1.6.1 Test Application:** Open EB environment URL and check functionality  

**1.6.2 Validate CloudWatch Email Subscriptions** – Confirm subscription confirmation emails  

**1.6.3 Connect to EC2 via Session Manager** – Verify instance connectivity  

**1.6.4 Verify CloudWatch Agent** – Check agent status and configuration  

**1.6.5 Trigger CPU & Memory Alarms:**

```bash
# CPU
stress-ng --cpu 0 --cpu-load 90 --timeout 300

# Memory
sudo stress-ng --vm 1 --vm-bytes 700M --vm-keep --vm-method all --vm-hang 180 -t 180s
```

**1.6.6 Verify Alarm State Changes** – CloudWatch shows OK → ALARM transitions  

**1.6.7 Validate Auto Scaling Activity** – ASG launches and terminates instances based on load  

**1.6.8 Verify Target Registration** – Instances appear healthy in target group  

**1.6.9 SNS Email Notifications** – Receive alerts for CPU/Memory utilization and EB environment health  

---

## Task 1.7: Clean Up

```bash
terraform destroy --auto-approve
```

Removes all resources to prevent unnecessary AWS charges.  

---

## Task 1.8: Troubleshooting

**Issue 1:** Invalid ELBScheme  
- **Solution:** Remove ELBScheme; EB defaults to public ALB  

**Issue 2:** Incorrect RootVolumeType  
- **Solution:** Correct assignment of `volume_type` and `volume_size`  

**Issue 3:** Missing EC2 Instance Profile  
- **Solution:** Add IAM instance profile and pass to EB module  

**Issue 4:** Custom CloudWatch Metrics not usable by EB  
- **Solution:** Create external CloudWatch alarms + SNS + scale policies via Terraform  

**Issue 5:** Insufficient Permissions for CloudWatch Agent  
- **Solution:** Add EC2 role permissions for `autoscaling:DescribeAutoScalingInstances` and `ec2:DescribeTags`  

---