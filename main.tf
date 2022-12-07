terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-gitops"
    region = "us-east-1"
    key = "terraform.tfstate"
    encrypt = true
  
  }
}
