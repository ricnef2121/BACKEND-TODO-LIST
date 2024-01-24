terraform {
  backend "s3" {
    bucket  = "mirepoparaTerraform"
    encrypt = true
    key     = "terraform.tfstate"
    region  = var.TFC_AWS_REGION
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
  region     = var.TFC_AWS_REGION
}
