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

    # SETUP Docker
    curl -fsSL https://get.docker.com | sh 

    # SETUP n8n
    mkdir -p /opt/n8n
    cd /opt/n8n
    mkdir local-files
    cat > /opt/n8n/.env <<'CONFIG'
    ${file("${path.module}/n8n-files/.env")}
    CONFIG
    cat > /opt/n8n/compose.yml <<'DOCKER_COMPOSE'
    ${file("${path.module}/n8n-files/compose.yaml")}
    DOCKER_COMPOSE
    docker compose up -d

    # SSH KEY
    cat > /root/.ssh/id_ed25519 <<'KEY'
    ${file("${path.module}/id_ed25519")}
    KEY
    chmod 600 /root/.ssh/id_ed25519
  EOL
}

output "tf_ec2_1_public_ip" {
  value = aws_instance.tf_ec2_1.public_ip
  description = "Public IP address of the public EC2 instance (tf_ec2_1)"
}
