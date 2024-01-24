variable "TFC_AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""

}
variable "TFC_AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}
# variable necesaria para poder crear la llave de acceso ssh a la instancia
variable "key_name" {
  type    = string
  default = "ssh-todo-list"
}

variable "TFC_AWS_REGION" {
  type    = string
  default = ""
}

variable "TFC_AWS_ACCESS_KEY_ID" {
  type = string
  default = ""
}
