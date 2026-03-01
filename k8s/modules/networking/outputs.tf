output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "ID of the VPC"
}

output "subnet_id" {
  value       = aws_subnet.subnet.id
  description = "ID of the subnet"
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "ID of the internet gateway"
}

output "route_table_id" {
  value       = aws_route_table.public_rt.id
  description = "ID of the public route table"
}
