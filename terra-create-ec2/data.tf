data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

# data "template_file" "user_data" {
  
#   template = "${file("scripts/install.tpl")}"
#   # template = file("scripts/install_docker.sh")

#   vars = {
#     name              = "Justin"
#     aws_access_key_id = aws_iam_access_key.grafana_user_access_key.id
#   }
# }
