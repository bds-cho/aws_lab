resource "aws_instance" "tf_ec2_1" {
  ami           = "ami-0a116fa7c861dd5f9"
  instance_type = "t3.small"
  subnet_id     = aws_subnet.tf_subnet.id
  key_name      = aws_key_pair.tf_key.key_name
  vpc_security_group_ids = [aws_security_group.tf_ssh.id]
  tags = {
    Name = "tf_ec2_1"
  }
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