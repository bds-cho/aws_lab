output "key_pair_name" {
  value       = aws_key_pair.key.key_name
  description = "Name of the key pair"
}

output "security_group_id" {
  value       = aws_security_group.public.id
  description = "ID of the security group"
}
