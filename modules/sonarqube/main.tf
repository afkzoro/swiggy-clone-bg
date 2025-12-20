data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group for SonarQube
resource "aws_security_group" "sonarqube" {
  name        = "${var.project_name}-sonarqube-sg"
  description = "Security group for SonarQube instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "SonarQube Web UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sonarqube-sg"
  }
}

# SonarQube EC2 Instance
resource "aws_instance" "sonarqube" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.medium"
  key_name      = var.key_pair_name
  
  vpc_security_group_ids = [aws_security_group.sonarqube.id]
  subnet_id              = var.public_subnet_id
  
  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install docker.io -y
              usermod -aG docker ubuntu
              systemctl restart docker
              chmod 777 /var/run/docker.sock
              docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
              EOF
  
  tags = {
    Name = "${var.project_name}-sonarqube"
  }
}

