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

# Configure the AWS Provider
provider "aws" {
  access_key = var.TFC_AWS_ACCESS_KEY_ID
  secret_key = var.TFC_AWS_SECRET_ACCESS_KEY
  region     = "us-east-1"
}

resource "aws_s3_bucket" "new_bucket" {
  bucket = "demo-github-action-tf-todo-list"

  tags = {
    Environment = "Prod"
  }
}
resource "aws_s3_bucket_public_access_block" "todo-list" {
 bucket = aws_s3_bucket.new_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "provision_source_files" {
  key    = "todo_list"
  bucket = aws_s3_bucket.new_bucket.id
  source     = "dist/main.js"
}

 

variable "TFC_AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""

}
variable "TFC_AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}
