output "master_id" {
  value       = aws_instance.master.id
  description = "ID of the master EC2 instance"
}

output "master_public_ip" {
  value       = aws_instance.master.public_ip
  description = "Public IP address of the master EC2 instance"
}

output "master_private_ip" {
  value       = aws_instance.master.private_ip
  description = "Private IP address of the master EC2 instance"
}

output "worker_ids" {
  value       = aws_instance.worker[*].id
  description = "IDs of the worker EC2 instances"
}

output "worker_public_ips" {
  value       = aws_instance.worker[*].public_ip
  description = "Public IP addresses of the worker EC2 instances"
}

output "worker_private_ips" {
  value       = aws_instance.worker[*].private_ip
  description = "Private IP addresses of the worker EC2 instances"
}
