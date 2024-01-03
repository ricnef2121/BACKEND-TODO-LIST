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
  backend "s3" {}
}
# variable necesaria para poder crear la llave de acceso ssh a la instancia
variable "key_name" {
  type    = string
  default = "ssh-todo-list"
}

resource "aws_ssm_parameter" "todo" {
  name  = "todo"
  type  = "string"
  value = "list"
}

provider "aws" {
  access_key = var.TFC_AWS_ACCESS_KEY_ID
  secret_key = var.TFC_AWS_SECRET_ACCESS_KEY
  region     = "us-east-1"
}
# recurso necesario para poder crear la llave de acceso ssh a la instancia
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# recurso necesario para poder crear la llave de acceso ssh a la instancia
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "example_server" {
  ami = "ami-079db87dc4c10ac91"
  #   user_data = <<EOF
  # #!/bin/bash
  # sudo yum update -y  
  # sudo yum install -y nodejs 
  # sudo yum install -y 
  # sudo mkdir /home/ec2-user/app 
  # cd /home/ec2-user/app 
  # echo "console.log('Hello, world!')" > index.js 
  # npm init -y npm install express --save 
  # echo "const express = require('express')" >> index.js 
  # echo "const app = express()" >> index.js 
  # echo "app.get('/', (req, res) => { res.send('Hello, world!') })" >> index.js    
  # echo "app.listen(3000, () => { console.log('Server running on port 3000') })" >> index.js 
  # npm start 
  # EOF


  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "TODO-LIST-BACKEND"
  }
  provisioner "remote-exec" {
    inline = ["sudo yum install -y nginx", "sudo systemctl start nginx", "sudo systemctl enable nginx"]
  }
}
# ouput necesario para poder crear la llave de acceso ssh a la instancia
output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}

variable "TFC_AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""

}
variable "TFC_AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}

