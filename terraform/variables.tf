variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "availability_zones" {
  description = "AZs to deploy subnets in"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "ecr_image_url" {
  description = "image = 753392824297.dkr.ecr.us-east-1.amazonaws.com/hello-world-repo:hello-world-buildx"
  type        = string
}