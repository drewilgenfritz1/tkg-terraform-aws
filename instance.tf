resource "aws_instance" "jumpbox" {
    ami  = var.jumpbox-ami
    instance_type = "t3.medium"
    key_name = "tmc-sandbox"
    vpc_security_group_ids = [ aws_security_group.jumpbox-ssh.id ]
    subnet_id = aws_subnet.pub-a.id
    
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 64
    }

    tags = {
      "Name" = "bastion"
    }
  
}

# # Create a Harbor instance in a public subnet
resource "aws_instance" "harbor" {
  ami           = "ami-0f5c680124b2a2c4e"  # Replace with the AMI ID for your desired Harbor instance
  instance_type = "t3.xlarge"               # Replace with your desired instance type
  subnet_id     = aws_subnet.pub-a.id
  vpc_security_group_ids = [aws_security_group.jumpbox-ssh.id]  # Allow SSH access from bastion host
  key_name = "tmc-sandbox"
  ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 128
    }

  tags = {
    Name = "Harbor Instance"
  }
}

# resource "tls_private_key" "cluster-key-private" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "cluster-key" {
#   key_name = "test-kp"
#   public_key = tls_private_key.cluster-key-private.public_key_openssh
# }