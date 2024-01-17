# Mostramos la IP pública de la instancia
output "elastic_ip" {
  value = aws_eip.ip_elastica.public_ip
}

# ouput necesario para poder crear la llave de acceso ssh a la instancia
output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}