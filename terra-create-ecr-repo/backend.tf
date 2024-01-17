# terraform {
#   # required_providers {
#   #   docker = {
#   #     source  = "kreuzwerker/docker"
#   #     version = "3.0.2"
#   #   }
#   # }

#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "example-org-35309e"

#     workspaces { 
#       name = "learn-terraform-github-actions"
#     }
#   }
# }

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
      docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  } 
}
