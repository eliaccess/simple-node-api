provider "aws" {
  region = "eu-west-3"
}

resource "aws_instance" "node_api" {
  ami           = "ami-00d81861317c2cc1f" # Amazon Linux 2 AMI in eu-west-3
  instance_type = "t2.micro"

  tags = {
    Name = "nodejs-api"
  }

  user_data = <<-EOF
  #!/bin/bash
  curl -sL https://rpm.nodesource.com/setup_16.x | bash -
  yum install -y nodejs git
  git clone https://github.com/eliaccess/simple-node-api.git /home/ec2-user/simple-node-api
  cd /home/ec2-user/simple-node-api
  npm install
  npm start
  EOF

  # Ensure SSH access (optional for debugging)
  key_name = var.aws_key_name

  security_groups = [aws_security_group.api_sg.name]
}

resource "aws_security_group" "api_sg" {
  name_prefix = "nodejs-api-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.node_api.public_ip
}

