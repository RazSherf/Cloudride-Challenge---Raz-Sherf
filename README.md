# Cloudride Challenge - Raz Sherf
Hello World on AWS ECS with CI/CD

This project deploys a simple “Hello World” container app on AWS using Terraform and GitHub Actions. It includes a VPC with public/private subnets, ECS with Fargate, an Application Load Balancer, auto scaling, and monitoring with CloudWatch alarms. The app is exposed to the internet only through the ALB.

What’s included?
	•	VPC with 2 public + 2 private subnets across multiple AZs
	•	ECS cluster running tasks in private subnets
	•	Application Load Balancer for internet traffic
	•	Service auto scaling with minimum 2 containers running
	•	CloudWatch alarm monitoring container errors
	•	ECR for Docker image storage
	•	CI/CD pipeline using GitHub Actions to build and deploy changes automatically

AWS Well-Architected Pillars
	•	Operational Excellence: Everything is automated with Terraform and GitHub Actions for consistent deployments and monitoring.
	•	Security: Containers run in private subnets, only exposed via ALB; least privilege IAM roles.
	•	Reliability: Multi-AZ deployment and auto scaling keep the app available and responsive.
	•	Performance Efficiency: Fargate scales containers on demand, load balancer balances traffic smoothly.
	•	Cost Optimization: Serverless Fargate and automated scaling help minimize costs.

How to run
	1.	Clone repo
	2.	Run Terraform (terraform init + terraform apply)
	3.	Push code to GitHub to trigger CI/CD
