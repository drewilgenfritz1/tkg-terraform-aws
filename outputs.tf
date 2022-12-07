output "vpc_id" {
  value = aws_vpc.TKGVPC.id
}

output "priv_subnet_a" {
  value = aws_subnet.priv-a.id
}

output "priv_subnet_b" {
  value = aws_subnet.priv-b.id
}

output "priv_subnet_c" {
  value = aws_subnet.priv-c.id
}

output "pub_subnet_a" {
  value = aws_subnet.pub-a.id
}

output "pub_subnet_b" {
  value = aws_subnet.pub-b.id
}

output "pub_subnet_c" {
  value = aws_subnet.pub-c.id
}

output "jumpbox_ip" {
  value = aws_instance.jumpbox.public_ip
}