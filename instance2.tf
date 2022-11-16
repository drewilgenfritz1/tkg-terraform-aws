resource "aws_instance" "jumpbox2" {
    ami  = var.jumpbox-ami
    instance_type = "t3.medium"
    key_name = "tkg-kp"
    security_groups = [ aws_security_group.jumpbox-ssh.id ]
    subnet_id = aws_subnet.pub-a.id
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 64
    }
    # connection {
    #   type = "ssh"
    #   user = "ubuntu"
    #   private_key = file("./data/tkgkp.pem")
    #   host = self.public_ip
    # }
    # # provisioner "file" {
    # #   source = "data/tanzu-cli-bundle-linux-amd64.tar.gz"
    # #   destination = "/home/ubuntu/tanzu-cli-bundle-linux-amd64.tar.gz"
      
    # # }
    # provisioner "file" {
    #   source = "data/kubectl-linux-v1.22.9+vmware.1.gz"
    #   destination = "/home/ubuntu/kubectl-linux-v1.22.9+vmware.1.gz"
      
    # }
    # user_data = file("./data/init.sh")
    tags = {
      "Name" = "jumpbox-tkg2"
    }
  
}