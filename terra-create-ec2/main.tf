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

# Configuramos el proveedor de AWS
provider "aws" {
  access_key = var.TFC_AWS_ACCESS_KEY_ID
  secret_key = var.TFC_AWS_SECRET_ACCESS_KEY
  region     = "us-east-1"
}

# Creamos un grupo de seguridad
resource "aws_security_group" "sg_example_04" {
  name        = "sg_example_04"
  description = "Grupo de seguridad para la instancia de ejemplo 04"

  # Reglas de entrada para permitir el tráfico SSH, HTTP y HTTPS
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # subred privada

  # Reglas de salida para permitir todas las conexiones salientes
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creamos una instancia EC2
resource "aws_instance" "instancia_ejemplo_04" {
  ami           = "ami-00874d747dde814fa"
  instance_type = "t2.small"
  key_name      = aws_key_pair.generated_key.key_name

  security_groups = [aws_security_group.sg_example_04.name]

  #user_data = file("scripts/install_docker.sh")
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "TODO-LIST-EC2"
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica" {
  instance = aws_instance.instancia_ejemplo_04.id
}



#Grafana user creation
resource "aws_iam_user" "grafana_user" {
  name = "grafana"
}


#Grafana user policy
resource "aws_iam_user_policy_attachment" "grafana_user_policy_attachment_ecs" {
  user       = aws_iam_user.grafana_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_user_policy_attachment" "grafana_user_policy_attachment_ec2" {
  user       = aws_iam_user.grafana_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "grafana_user_policy_attachment_S3" {
  user       = aws_iam_user.grafana_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_access_key" "grafana_user_access_key" {
  user = aws_iam_user.grafana_user.name
}

