resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.public
  ]
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  allocation_id = aws_eip.Nat-Gateway-EIP.id
  
  subnet_id = aws_subnet.my-public-subnet.id
  tags = {
    Name = "my-nat-gateway"
  }
}