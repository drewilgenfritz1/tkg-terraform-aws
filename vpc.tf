resource "aws_vpc" "TKGVPC" {
    cidr_block = var.base_cidr_block

    tags = {
      "Name" = "testVPC"
    }
}

resource "aws_internet_gateway" "tkg-inet-gw" {
    vpc_id = aws_vpc.TKGVPC.id

    tags = {
        "Name" = "${var.env}-inet-gw"
    } 
  
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.tkg-eip.id
  subnet_id     = aws_subnet.pub-a.id

  tags = {
    Name = "${var.env}-nat-gw"
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
  cidr_block = var.private-cidr-a
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.env}-priv-a"
  }
}

resource "aws_subnet" "priv-b" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = var.private-cidr-b
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.env}-priv-b"
  }
}

resource "aws_subnet" "priv-c" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = var.private-cidr-c
  availability_zone = "us-east-1c"

  tags = {
    Name = "${var.env}-priv-c"
  }
}

resource "aws_subnet" "pub-a" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = var.public-cidr-a
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-pub-a"
  }
}

resource "aws_subnet" "pub-b" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = var.public-cidr-b
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-pub-b"
  }
}

resource "aws_subnet" "pub-c" {
  vpc_id     = aws_vpc.TKGVPC.id
  cidr_block = var.public-cidr-c
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-pub-c"
  }
}

resource "aws_ec2_transit_gateway" "transit-gw" {
  description = "For TKG Transit"

  tags = {
    Name = "${var.env}-tansit-gw"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment-transit-gw" {
  subnet_ids         = [aws_subnet.priv-a.id, aws_subnet.priv-b.id, aws_subnet.priv-c.id]
  transit_gateway_id = aws_ec2_transit_gateway.transit-gw.id
  vpc_id             = aws_vpc.TKGVPC.id
}

