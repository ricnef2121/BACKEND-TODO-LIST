terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "example-org-35309e"

    workspaces { 
      prefix = "learn-terraform-github-actions"
    }
  }
}
