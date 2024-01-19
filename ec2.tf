data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "this" {
  name        = "allow-ssh-from-own-IP-only"
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    description = "SSH from the internet"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["217.65.104.98/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "private" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.this.key_name
  security_groups = [aws_security_group.this.id]
  subnet_id = aws_subnet.my-private-subnet.id

  tags = {
    Name = "ec2-private-hitc"
  }
}

resource "aws_instance" "public" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.this.key_name
  security_groups = [aws_security_group.this.id]
  subnet_id = aws_subnet.my-public-subnet.id

  tags = {
    Name = "ec2-public-hitc"
  }
}

resource "aws_key_pair" "this" {
  key_name = "feldicskobalazs-key"
  public_key = file("~/.ssh/id_rsa.pub")
}