locals {
  vpc_name             = "${var.environment}_vpc"
  subnet_name          = "${var.environment}_subnet"
  igw_name             = "${var.environment}_igw"
  route_table_name     = "${var.environment}_public_rt"
  route_table_assoc    = "${var.environment}_public_assoc"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = local.vpc_name
    }
  )
}

resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = merge(
    var.common_tags,
    {
      Name = local.subnet_name
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.common_tags,
    {
      Name = local.igw_name
    }
  )
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block      = "0.0.0.0/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = local.route_table_name
    }
  )
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public_rt.id
}
