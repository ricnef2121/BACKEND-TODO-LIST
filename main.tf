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
  region     = "us-east-1"
}

resource "aws_instance" "example_server" {
  ami           = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"
   tags = {
    Name = "TODO-LIST-BACKEND"
  }
}

variable "TFC_AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""

}
variable "TFC_AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""

}