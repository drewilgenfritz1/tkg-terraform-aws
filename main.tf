terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.13.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.1"
    }
    carvel = {
      source = "vmware-tanzu/carvel"
      version = "0.10.0"
    }
  }

  # backend "s3" {
  #   bucket = "terraform-state-gitops"
  #   region = "us-east-1"
  #   key = "terraform.tfstate"
  #   encrypt = true
  
  # }
}

provider "kubernetes" {
  config_path    = "/home/drew/.kube/config"
  config_context = "arn:aws:eks:us-east-1:183367433239:cluster/tmc-sandbox"
}

provider "carvel" {
  kapp {
    kubeconfig {
      from_env = true
    }
  }
}

module "cert-manager" {
  source  = "./modules/cert-manager"
  cluster_issuer_email                   = "admin@mysite.com"
  cluster_issuer_name                    = "tmc-cert-manager"
  cluster_issuer_private_key_secret_name = "tmc-cert-manager-private-key"
}

# module "harbor" {
#   source = "./modules/terraform-digitalocean-doks-harbor"

#   harbor_ext_url = var.harbor_ext_url

#   doks_cluster_name = var.doks_cluster_name

#   spaces_access_id  = var.spaces_access_id
#   spaces_secret_key = var.spaces_secret_key
# }

resource "null_resource" "kubectl" {
    provisioner "local-exec" {
        command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}"
    }
}




resource "carvel_kapp" "kapp-controller" {
  app = "kapp-controller"
  namespace = "kapp-controller"

  config_yaml = "${file("kapp-controller.yml")}"
  
}

