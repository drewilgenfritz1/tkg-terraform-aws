resource "aws_security_group" "jumpbox-ssh" {
    description = "To jumpbox"
    vpc_id = aws_vpc.TKGVPC.id

    tags = {
      "Name" = "jumpbox-ssh"
    }
}

resource "aws_security_group_rule" "ssh_ingress" {
    type = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.jumpbox-ssh.id
    
}

resource "aws_security_group_rule" "https_ingress" {
    type = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.jumpbox-ssh.id
    
}

resource "aws_security_group_rule" "https_egress" {
    type = "egress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.jumpbox-ssh.id
    
}

resource "aws_security_group_rule" "ephemerals_ingress" {
    type = "ingress"
    from_port         = 1024
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.jumpbox-ssh.id
    
}

resource "aws_security_group_rule" "ephemerals_egress" {
    type = "egress"
    from_port         = 1024
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.jumpbox-ssh.id
    
}