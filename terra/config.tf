terraform {
  cloud {
    organization = "example-org-35309e"

    workspaces {
      name = "learn-terraform-github-actions"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
} 
 

provider "aws" {
  access_key = var.TFC_AWS_ACCESS_KEY_ID
  secret_key = var.TFC_AWS_SECRET_ACCESS_KEY
  region     = var.TFC_AWS_ACCESS_KEY_ID
}

# resource "aws_instance" "example_server" {
#   ami = "ami-079db87dc4c10ac91" 

#   instance_type = "t2.micro"
#   key_name      = aws_key_pair.generated_key.key_name
#   tags = {
#     Name = "TODO-LIST-BACKEND"
#   } 
# }
