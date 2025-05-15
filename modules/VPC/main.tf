provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "practice01" {
  cidr_block           = "10.10.0.0/20"
  tags = {
    Name = "terraform-practice-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.practice01.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "practice01-public" {
  vpc_id                  = aws_vpc.practice01.id
  cidr_block              = "10.10.16.0/20"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.practice01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_subnet" "practice01-private" {
  vpc_id            = aws_vpc.practice01.id
  cidr_block        = "10.10.32.0/20"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.practice01-public.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}



resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.practice01-public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.practice01.id

  route {
    cidr_block     = "10.10.16.0/20"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.practice01-private.id
  route_table_id = aws_route_table.private.id
}
