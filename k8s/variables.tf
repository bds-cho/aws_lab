variable "aws_access_id" {
  description = "AWS access key ID"
  type        = string
  sensitive   = true
}

variable "aws_access_secret" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "k8s"
}

# Networking variables
variable "az" {
  description = "Availability zone"
  type        = string
  default     = "eu-central-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Compute variables
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0a116fa7c861dd5f9"
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 1
}

# Security variables
variable "ssh_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
