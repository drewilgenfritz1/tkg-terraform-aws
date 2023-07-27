variable "aws_region" {
    default="us-east-1"
}

variable "base_cidr_block" {
  description = "main cidr block"
  default = "172.16.0.0/16"
}

variable "env" {
  
}

variable "cluster_name" {
  
}

variable "private-cidr-a" {
  
}

variable "private-cidr-b" {
  
}

variable "private-cidr-c" {
  
}

variable "public-cidr-a" {
  
}

variable "public-cidr-b" {
  
}

variable "public-cidr-c" {
  
}

variable "keypair" {
  
}


# # variable "cidrs" {
# #   type = map(string)
# #   default =  {
# #     private-cidr-a = ""
# #     private-cidr-b = ""
# #     private-cidr-c = ""
# #     public-cidr-a =  ""
# #     public-cidr-b = ""
# #     public-cidr-c = ""   
# #   }
# # }

# # variable "base_cidr_block2" {
# #   description = "main cidr block"
# #   default = "172.17.0.0/16"
# # }

# # # variable "availability_zones" {
# # #   description = "A list of availability zones in which to create subnets"
# # #   type = list(string)
# # # }

variable "jumpbox-ami" {
    #Custom AMI with all necessary CLIs already installed
    description = "Ubuntu 16.04"
    default = "ami-0b0ea68c435eb488d"
    # default = "ami-061716e67fd4bc8b3"
  
}
