provider "aws" {
  access_key = var.TFC_AWS_ACCESS_KEY_ID
  secret_key = var.TFC_AWS_SECRET_ACCESS_KEY
  region     = var.TFC_AWS_REGION
}

# provider "docker" {
#  # host ="unix:///home/user/.docker/desktop/docker.sock"
#   registry_auth {
#     address  = local.aws_ecr_url
#     username = data.aws_ecr_authorization_token.token.user_name
#     password = data.aws_ecr_authorization_token.token.password
#   }
# }