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
echo export AWS_ACCESS_KEY_ID="${access}" >> config.sh
echo export AWS_SECRET_ACCESS_KEY="${secret}"  >> config.sh
echo export AWS_DEFAULT_REGION="${region}"  >> config.sh
echo export IMAGE="${image}"  >> config.sh
# configuramos las credenciales de aws
echo "echo -e "${AWS_ACCESS_KEY_ID}\n${AWS_SECRET_ACCESS_KEY}\n${AWS_DEFAULT_REGION}\njson" | aws configure" >> config.sh
# logueamos el usuario en el repositorio de ecr
echo "docker login -u AWS -p $(aws ecr get-login-password --region ${region})  ${docker}.dkr.ecr.${region}.amazonaws.com/${IMAGE}:latest" >> config.sh
# bajamos la imagen docker de ecr
echo "sudo docker pull ${docker}.dkr.ecr.${region}.amazonaws.com/${IMAGE}:latest" >> config.sh
# creamos un contenedor con la imagen que descargamos
echo "sudo docker run -dti --name "todo-back" -p 3000:3000 ${docker}.dkr.ecr.${region}.amazonaws.com/${IMAGE}:latest"
chmod 744 config.sh
./config.sh





# sudo docker pull ${docker}.dkr.ecr.${region}.amazonaws.com/backend:latest    
# sudo docker pull 945867449148.us-west-1.amazonaws.com/backend:latest 
# sudo docker pull 945867449148.dkr.ecr.us-east-1.amazonaws.com/backend:latest    
# docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 945867449148.dkr.ecr.us-east-1.amazonaws.com/backend:latest


# #!/bin/bash
# AWS_ACCESS_KEY_ID=AKIA5YOQX4M6O7KNEDKG
# AWS_SECRET_ACCESS_KEY=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
# AWS_DEFAULT_REGION=us-west-1
# export IMAGE=945867449148
# echo -e "${AWS_ACCESS_KEY_ID}\n${AWS_SECRET_ACCESS_KEY}\n${AWS_DEFAULT_REGION}\njson" | aws configure
# aws configure list
# docker login -u AWS -p $(aws ecr get-login-password --region us-east-1) 945867449148.dkr.ecr.us-east-1.amazonaws.com/backend:latest
# sudo docker pull 945867449148.dkr.ecr.us-east-1.amazonaws.com/backend:latest
# sudo docker images
# sudo docker run -dti --name "todo-back" -p 3000:3000 945867449148.dkr.ecr.us-east-1.amazonaws.com/backend:latest
       
# # echo "#!/bin/bash"  > config.sh
# # echo touch credentials
# # echo "[default]" >> credentials
# # echo "aws_access_key_id = "${access}"" >> credentials
# # echo " aws_secret_access_key = "${secret}"" >> credentials
# # echo "region = "${region}"" >> credentials
# # chmod 744 config.sh
# # ./config.sh






# echo "#!/bin/bash"  > config.sh
# echo "export AWS_ACCESS_KEY_ID="${access}"" >> config.sh
# echo "export AWS_SECRET_ACCESS_KEY="${secret}"" >> config.sh
# echo "export AWS_DEFAULT_REGION="${region}"" >> config.sh
# chmod 744 config.sh
# ./config.sh


# sudo echo "#!/bin/bash"  > config.sh
# sudo echo export AWS_ACCESS_KEY_ID="${access}" > config.sh
# sudo echo export AWS_SECRET_ACCESS_KEY="${secret}"  > config.sh
# sudo echo export AWS_DEFAULT_REGION="${region}"  > config.sh

# export AWS_SECRET_ACCESS_KEY="TU_SECRET_KEY"
# export AWS_DEFAULT_REGION="TU_REGION"
 

# printenv | less