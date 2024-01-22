#!/bin/bash

# Script de instalación de Docker y Docker Compose
# Referencia: https://docs.docker.com/engine/install/ubuntu/

set -x

# Actualizamos los repositorios
apt update 

# Instalamos los paquetes necesarios para que `apt` pueda usar repositorios sobre HTTPS
apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Añadimos la clave GPG oficial de Docker
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Añadimos el repositorio oficial de Docker a nuestro sistema
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualizamos la lista de paquetes
apt update

# Instalamos la última versión de Docker y Docker Compose
apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Añadimos el usuario actual al grupo docker 
usermod -aG docker $USER

# Habilitamos el servicio de Docker para que se inicie automáticamente al arrancar el sistema
systemctl enable docker

# Iniciamos el servicio de Docker
systemctl start docker

apt-get update     

sudo apt-get install -y awscli

# mkdir ~/.aws
# cd ~/.aws


touch config.sh
echo "#!/bin/bash"  >> config.sh 
# configuramos las credenciales de aws
echo "echo -e "${access}\n${secret}\n${region}\njson" | aws configure" >> config.sh
# logueamos el usuario en el repositorio de ecr
echo "docker login -u AWS -p $(aws ecr get-login-password --region ${region})  ${docker}.dkr.ecr.${region}.amazonaws.com/${image}:latest" >> config.sh
# bajamos la imagen docker de ecr
echo "sudo docker pull ${docker}.dkr.ecr.${region}.amazonaws.com/${image}:latest" >> config.sh
# creamos un contenedor con la imagen que descargamos
echo "sudo docker run -dti --name "todo-back" -p 3000:3000 ${docker}.dkr.ecr.${region}.amazonaws.com/${image}:latest"
chmod 744 config.sh
./config.sh