## Create ECR repository
# resource "aws_ecr_repository" "repository" {
#   for_each             = toset(var.repository_list)
#   name                 = each.key
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   encryption_configuration {
#     encryption_type = "AES256"
#   }
# } 

resource "aws_ecr_repository" "backend" {
  name                 = "backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

# resource "aws_ecr_lifecycle_policy" "default_policy_docker" {
#   repository = aws_ecr_repository.backend.name
#   policy     = <<EOF
# 	{
# 	    "rules": [
# 	        {
# 	            "rulePriority": 1,
# 	            "description": "Keep only the last 1 untagged images.",
# 	            "selection": {
# 	                "tagStatus": "untagged",
# 	                "countType": "imageCountMoreThan",
# 	                "countNumber": 1
# 	            },
# 	            "action": {
# 	                "type": "expire"
# 	            }
# 	        }
# 	    ]
# 	}
# 	EOF
# }


## Build docker images and push to ECR
# resource "docker_registry_image" "backend" {
#   for_each = toset(var.repository_list)
#   name     = "${aws_ecr_repository.repository[each.key].repository_url}:latest"

#   build {
#     # Default values
#     # context    = "../application"
#     # dockerfile = "${each.key}.Dockerfile"

#     # Custom Values
#     context    = "./"
#     dockerfile = ".Dockerfile"
#   }
# }

# resource "docker_registry_image" "backend" {
#   name          = "${aws_ecr_repository.backend.repository_url}:latest"
#   keep_remotely = true

#   build {
#     context    = "../"
#     dockerfile = ".Dockerfile"
#   }
# }

# resource "docker_image" "image" {
#   name = "${aws_ecr_repository.backend.repository_url}:latest"
#   build {
#     context    = "../"
#     dockerfile = ".Dockerfile"
#   }
# }

# resource "null_resource" "docker_packaging" {

#   provisioner "local-exec" {
#     command = <<EOF
# 	    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
#       docker
# 	    docker build -t "${aws_ecr_repository.backend.repository_url}:latest" -f backend/Dockerfile .
# 	    docker push "${aws_ecr_repository.backend.repository_url}:latest"
# 	    EOF
#   }


#   triggers = {
#     "run_at" = timestamp()
#   }


#   depends_on = [
#     aws_ecr_repository.backend,
#   ]
# }




