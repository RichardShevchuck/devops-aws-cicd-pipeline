resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}


resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_block1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}


resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_block2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}


resource "aws_route_table" "aws_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.aws_route_table.id
}


resource "aws_route_table_association" "subnet_association2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.aws_route_table.id
}

