resource "aws_instance" "tf_ec2_1" {
  ami           = "ami-0a116fa7c861dd5f9"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.tf_subnet.id
  key_name      = aws_key_pair.tf_key.key_name
  vpc_security_group_ids = [aws_security_group.tf_public.id]
  tags = {
    Name = "tf_ec2_1"
  }
  user_data = <<-EOL
    #!/bin/bash -xe
    apt update -y && apt upgrade -y
    apt install -y net-tools
  EOL
}

resource "aws_instance" "tf_ec2_2" {
  ami           = "ami-0a116fa7c861dd5f9"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.tf_subnet.id
  key_name      = aws_key_pair.tf_key.key_name
  vpc_security_group_ids = [aws_security_group.tf_private.id]
  associate_public_ip_address = false
  tags = {
    Name = "tf_ec2_2"
  }
}

output "tf_ec2_1_public_ip" {
  value = aws_instance.tf_ec2_1.public_ip
  description = "Public IP address of the public EC2 instance (tf_ec2_1)"
}

output "tf_ec2_2_private_ip" {
  value = aws_instance.tf_ec2_2.private_ip
  description = "Private IP address of the private EC2 instance (tf_ec2_2)"
}