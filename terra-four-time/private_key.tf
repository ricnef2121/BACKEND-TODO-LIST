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