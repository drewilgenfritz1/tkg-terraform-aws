output "aws-vpc-id" {
  value = aws_vpc.TKGVPC.id
}

output "aws-vpc-cidr"{
  value = aws_vpc.TKGVPC.cidr_block
}

output "aws-private-subnet-id" {
  value = aws_subnet.priv-a.id
}

output "aws-private-subnet-id-1" {
  value = aws_subnet.priv-b.id
}

output "aws-private-subnet-id-2" {
  value = aws_subnet.priv-c.id
}

output "aws-public-subnet-id" {
  value = aws_subnet.pub-a.id
}

output "aws-public-subnet-id-1" {
  value = aws_subnet.pub-b.id
}

output "aws-public-subnet-id-2" {
  value = aws_subnet.pub-c.id
}

output "region"{
    value = var.aws_region
}

output "aws-public-node-cidr"{
  value = aws_subnet.pub-a.cidr_block
}

output "aws-public-node-cidr-1"{
  value = aws_subnet.pub-b.cidr_block
}

output "aws-public-node-cidr-2"{
  value = aws_subnet.pub-c.cidr_block
}

output "aws-private-node-cidr" {
  value = aws_subnet.priv-a.cidr_block
}

output "aws-private-node-cidr-1" {
  value = aws_subnet.priv-b.cidr_block
}

output "aws-private-node-cidr-2" {
  value = aws_subnet.priv-c.cidr_block
}

output "name" {
  value = var.cluster_name
}

output "cluster-key"{
  value = aws_key_pair.cluster-key.key_name
}

