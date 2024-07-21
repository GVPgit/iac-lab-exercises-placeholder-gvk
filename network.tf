resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "var.prefix"
  }
}
resource "aws_subnet" "pubsub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet1_cidr
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "pubsub1"
  }
}
resource "aws_subnet" "prisub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet2_cidr
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "prisub1"
  }
}
resource "aws_subnet" "secsub1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet3_cidr
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "secsub1"
  }
}
resource "aws_subnet" "pubsub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet4_cidr
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "pubsub2"
  }
}
resource "aws_subnet" "prisub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet5_cidr
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "prisub2"
  }
}
resource "aws_subnet" "secsub2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet6_cidr
  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "secsub2"
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw"
  }
}
resource "aws_eip" "myeip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "mynat" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pubsub1.id

  tags = {
    Name = "mynat"
  }
}
resource "aws_route_table" "mypubrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "mypubrt"
  }
}
resource "aws_route_table" "mypvtrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mynat.id
  }

  tags = {
    Name = "mypvtrt"
  }
}
resource "aws_route_table_association" "mypubrtasso1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.mypubrt.id
}
resource "aws_route_table_association" "mypubrtasso2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.mypubrt.id
}
resource "aws_route_table_association" "mypvtrtasso1" {
  subnet_id      = aws_subnet.prisub1.id
  route_table_id = aws_route_table.mypvtrt.id
}
resource "aws_route_table_association" "mypvtrtasso2" {
  subnet_id      = aws_subnet.prisub2.id
  route_table_id = aws_route_table.mypvtrt.id
}

