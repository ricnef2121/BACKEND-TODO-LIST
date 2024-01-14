## Create ECR repository
resource "aws_ecr_repository" "repository" {
  for_each             = toset(var.repository_list)
  name                 = each.key
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}

resource "aws_ecr_lifecycle_policy" "default_policy" {
  repository = aws_ecr_repository.repository.name
	

	  policy = <<EOF
	{
	    "rules": [
	        {
	            "rulePriority": 1,
	            "description": "Keep only the last 1 untagged images.",
	            "selection": {
	                "tagStatus": "untagged",
	                "countType": "imageCountMoreThan",
	                "countNumber": 1
	            },
	            "action": {
	                "type": "expire"
	            }
	        }
	    ]
	}
	EOF
	

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
    dockerfile = ".Dockerfile"
  }
}

## Setup proper credentials to push to ECR



 
