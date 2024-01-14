variable "TFC_AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}
variable "TFC_AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}

variable "region" {
  description = "AWS region to create resources in"
  type  = string
  default = "us-east-1"
}

variable "repository_list" {
  description = "List of repository names"
  type = list
  # Default value
  # default = ["backend", "worker"]
  default = ["backend"]
}