resource "aws_instance" "master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${var.scripts_path}/master.sh")

  tags = merge(
    var.common_tags,
    {
      Name = "master"
    }
  )
}

resource "aws_instance" "worker" {
  count                  = var.worker_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  user_data_base64 = base64encode(templatefile("${var.scripts_path}/worker.sh", {
    worker_index = count.index + 1
  }))

  tags = merge(
    var.common_tags,
    {
      Name = "worker_${count.index + 1}"
    }
  )
}
