resource "aws_route_table" "priv-rt" {
    vpc_id = aws_vpc.TKGVPC.id

    tags = {
      "Name" = "tkgvpc-priv-rt"
    }
  
}

resource "aws_route" "default" {
  route_table_id            = aws_route_table.priv-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.nat-gw.id
  depends_on                = [aws_route_table.priv-rt]
}

resource "aws_route" "priv-route-1" {
  route_table_id            = aws_route_table.priv-rt.id
  destination_cidr_block    = "172.16.0.0/12"
  transit_gateway_id        = aws_ec2_transit_gateway.transit-gw.id
  depends_on                = [aws_route_table.priv-rt]
}

resource "aws_route_table_association" "priv-a" {
  subnet_id      = aws_subnet.priv-a.id
  route_table_id = aws_route_table.priv-rt.id
}

resource "aws_route_table_association" "priv-b" {
  subnet_id      = aws_subnet.priv-b.id
  route_table_id = aws_route_table.priv-rt.id
}

resource "aws_route_table_association" "priv-c" {
  subnet_id      = aws_subnet.priv-c.id
  route_table_id = aws_route_table.priv-rt.id
}

resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.TKGVPC.id

    tags = {
      "Name" = "tkgvpc-pub-rt"
    }
  
}

resource "aws_route" "default-pub" {
  route_table_id            = aws_route_table.pub-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.tkg-inet-gw.id
  depends_on                = [aws_route_table.pub-rt]
}

resource "aws_route" "pub-route-1" {
  route_table_id            = aws_route_table.pub-rt.id
  destination_cidr_block    = "172.16.0.0/12"
  transit_gateway_id        = aws_ec2_transit_gateway.transit-gw.id
  depends_on                = [aws_route_table.pub-rt]
}

resource "aws_route_table_association" "pub-a" {
  subnet_id      = aws_subnet.pub-a.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "pub-b" {
  subnet_id      = aws_subnet.pub-b.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "pub-c" {
  subnet_id      = aws_subnet.pub-c.id
  route_table_id = aws_route_table.pub-rt.id
}