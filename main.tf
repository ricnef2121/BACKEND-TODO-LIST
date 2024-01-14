## Create ECR repository
resource "aws_ecr_repository" "repository" {
  for_each = toset(var.repository_list)
  name     = each.key
}


## Build docker images and push to ECR
resource "docker_registry_image" "backend" {
  for_each = toset(var.repository_list)
  name     = "${aws_ecr_repository.repository[each.key].repository_url}:latest"

  build {
    # Default values
    # context    = "../application"
    # dockerfile = "${each.key}.Dockerfile"

    # Custom Values
    context    = "./"
    dockerfile =  ".Dockerfile"
  }
}

## Setup proper credentials to push to ECR

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
  region     = var.region
}
