resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "my-private-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.10.0.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "my-private-subnet"
  }
}

resource "aws_subnet" "my-public-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-public-subnet"
  }
}

resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.this
  ]

  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}

resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  subnet_id      = aws_subnet.my-private-subnet.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}


resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gateway.id
  }

  tags = {
    Name = "my-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.my-public-subnet.id
  route_table_id = aws_route_table.public.id
}

