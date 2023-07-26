# terraform.tfvars
# Set your AWS access and secret key here or use environment variables.



# Create an EKS cluster in the VPC
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.pub-a.id,
      aws_subnet.pub-b.id,
      aws_subnet.pub-c.id
    ]
  }
}

# Create an IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"
  permissions_boundary  = "arn:aws:iam::183367433239:policy/PowerUserPermissionsBoundaryPolicy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

# Create an IAM role for the EKS node groups
resource "aws_iam_role" "eks_node_group" {
  name = "eks-node-group-role"
  permissions_boundary  = "arn:aws:iam::183367433239:policy/PowerUserPermissionsBoundaryPolicy"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the required policies to the EKS node group role
resource "aws_iam_role_policy_attachment" "eks_node_group_policies" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group.name

  depends_on = [
    aws_iam_role.eks_node_group,
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group.name

  depends_on = [
    aws_iam_role.eks_node_group,
  ]
}

resource "aws_iam_role_policy_attachment" "eks_csi_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_node_group.name

  depends_on = [
    aws_iam_role.eks_node_group,
  ]
}

resource "aws_iam_role_policy_attachment" "eks_csi_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.eks_cluster.name

  depends_on = [
    aws_iam_role.eks_node_group,
  ]
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group.name

  depends_on = [
    aws_iam_role.eks_node_group,
  ]
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name

  depends_on = [
    aws_iam_role.eks_cluster,
  ]
}

resource "aws_eks_node_group" "worker-group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "tmc-sandbox-workers"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  instance_types = ["t3.xlarge"]
  subnet_ids = [
  aws_subnet.pub-a.id,
  aws_subnet.pub-b.id,
  aws_subnet.pub-c.id
  ]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  launch_template {
    name = "tmc-sandbox-worker"
    version = 1
  }
}

resource "aws_launch_template" "tmc-sandbox-worker" {
  name = "tmc-sandbox-worker"
  
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "tmc-sandbox-worker"
    }
  }
}

resource "aws_eks_addon" "csi" {
  cluster_name = aws_eks_cluster.main.name
  addon_name = "aws-ebs-csi-driver"
}

