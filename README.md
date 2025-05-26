# Hello World on AWS ECS with CI/CD

This project deploys a simple **"Hello World"** container app on AWS using **Terraform** and **GitHub Actions**. It sets up a VPC with public and private subnets, an ECS cluster running tasks on Fargate, an Application Load Balancer (ALB), auto scaling, and monitoring with CloudWatch alarms. The app is exposed to the internet only through the ALB.

---

## What’s included?

- **VPC** with 2 public and 2 private subnets across multiple Availability Zones  
- **ECS Cluster** running tasks in private subnets  
- **Application Load Balancer (ALB)** for internet traffic  
- **Service Auto Scaling** with a minimum of 2 running containers  
- **CloudWatch Alarm** monitoring container errors  
- **ECR** repository for Docker image storage  
- **CI/CD Pipeline** using GitHub Actions for automated build and deploy

---

## AWS Well-Architected Pillars

### Operational Excellence  
- Automated infrastructure deployment with Terraform  
- Continuous deployment and monitoring via GitHub Actions and CloudWatch  

### Security  
- Tasks run in private subnets, only accessible through the ALB  
- IAM roles follow least privilege principles  

### Reliability  
- Multi-AZ deployment for high availability  
- Auto Scaling ensures minimum container count is maintained  

### Performance Efficiency  
- Fargate dynamically manages compute resources  
- ALB balances incoming traffic evenly across containers  

### Cost Optimization  
- Serverless Fargate reduces idle resource costs  
- Auto Scaling adjusts capacity based on demand  

---

## How to Run

1. Clone this repository  
2. Initialize and apply Terraform:
    ```bash
    terraform init
    terraform apply
    ```
3. Push code changes to GitHub to trigger the CI/CD pipeline  

---
