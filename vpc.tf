resource "aws_vpc" "TKGVPC" {
    cidr_block = var.base_cidr_block

    tags = {
      "Name" = "TKGVPC2"
    }
}

resource "aws_internet_gateway" "tkg-inet-gw" {
    vpc_id = aws_vpc.TKGVPC.id

    tags = {
        "Name" = "tkg-inet-gw2"
    } 
  
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.tkg-eip.id
  subnet_id     = aws_subnet.pub-a.id

  tags = {
    Name = "nat-gw2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.tkg-inet-gw]
}

resource "aws_eip" "tkg-eip" {
    vpc = true
  
}

resource "aws_subnet" "priv-a" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "priv-a2"
  }
}

resource "aws_subnet" "priv-b" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "priv-b2"
  }
}

resource "aws_subnet" "priv-c" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.2.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "priv-c2"
  }
}

resource "aws_subnet" "pub-a" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-a2"
  }
}

resource "aws_subnet" "pub-b" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-b2"
  }
}

resource "aws_subnet" "pub-c" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = "172.16.5.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-c2"
  }
}

resource "aws_ec2_transit_gateway" "transit-gw" {
  description = "For TKG Transit"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment-transit-gw" {
  subnet_ids         = [aws_subnet.priv-a.id, aws_subnet.priv-b.id, aws_subnet.priv-c.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit-gw.id
  vpc_id             = aws_vpc.TKGVPC.id
}