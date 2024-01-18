data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

data "template_file" "user_data" {
  template = <<-EOF
              #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -E bash -c 'gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'
                echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
                usermod -aG docker $USER
                systemctl enable docker
                systemctl start docker
                sudo apt-get update     
                export AWS_ACCESS_KEY_ID=${aws_iam_access_key.grafana_user_access_key.id}    
                export AWS_SECRET_ACCESS_KEY=${aws_iam_access_key.grafana_user_access_key.secret}
                export AWS_DEFAULT_REGION=us-east-1       
                sudo apt-get install -y awscli
                # Configure aws
                aws configure set aws_access_key_id  $AWS_ACCESS_KEY_ID; aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY; aws configure set default.region $AWS_DEFAULT_REGION
                # Login to ECR (ensure you have the AWS CLI configured and valid credentials)
                aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.TFC_AWS_REGION}.amazonaws.com"
                # Docker pull
                sudo docker pull ${data.aws_caller_identity.current.account_id}.${var.TFC_AWS_REGION}.amazonaws.com/backend:latest                
                # Create container
                # sudo docker run -dti --name "todo-back" -p 3000:3000 ${data.aws_caller_identity.current.account_id}.${var.TFC_AWS_REGION}.amazonaws.com/backend
              EOF
}
# sudo apt-get update                
# sudo apt-get install -y python3 python3-pip
# sudo apt-get install -y awscli
# sudo pip3 install docker-compose
#  crear usuario de aplicacion
#  export AWS_ACCESS_KEY_ID=${aws_iam_access_key.grafana_user_access_key.id}
#  export AWS_SECRET_ACCESS_KEY=${aws_iam_access_key.grafana_user_access_key.secret}
#  export AWS_DEFAULT_REGION=us-east-1
