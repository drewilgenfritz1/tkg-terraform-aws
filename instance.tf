resource "aws_instance" "jumpbox" {
    ami  = var.jumpbox-ami
    instance_type = "t3.medium"
    key_name = aws_key_pair.cluster-key.key_name
    vpc_security_group_ids = [ aws_security_group.jumpbox-ssh.id ]
    subnet_id = aws_subnet.pub-a.id
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 64
    }

    tags = {
      "Name" = "jumpbox-test-scenario"
    }
  
}

resource "tls_private_key" "cluster-key-private" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "cluster-key" {
  key_name = "test-kp"
  public_key = tls_private_key.cluster-key-private.public_key_openssh
}