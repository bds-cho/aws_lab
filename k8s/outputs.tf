# Networking outputs
output "vpc_id" {
  value       = module.networking.vpc_id
  description = "ID of the VPC"
}

output "subnet_id" {
  value       = module.networking.subnet_id
  description = "ID of the subnet"
}

output "igw_id" {
  value       = module.networking.igw_id
  description = "ID of the internet gateway"
}

output "route_table_id" {
  value       = module.networking.route_table_id
  description = "ID of the public route table"
}

# Security outputs
output "security_group_id" {
  value       = module.security.security_group_id
  description = "ID of the security group"
}

output "key_pair_name" {
  value       = module.security.key_pair_name
  description = "Name of the key pair"
}

# Compute outputs
output "master_id" {
  value       = module.compute.master_id
  description = "ID of the master EC2 instance"
}

output "master_public_ip" {
  value       = module.compute.master_public_ip
  description = "Public IP address of the master EC2 instance"
}

output "master_private_ip" {
  value       = module.compute.master_private_ip
  description = "Private IP address of the master EC2 instance"
}

output "worker_ids" {
  value       = module.compute.worker_ids
  description = "IDs of the worker EC2 instances"
}

output "worker_public_ips" {
  value       = module.compute.worker_public_ips
  description = "Public IP addresses of the worker EC2 instances"
}

output "worker_private_ips" {
  value       = module.compute.worker_private_ips
  description = "Private IP addresses of the worker EC2 instances"
}
