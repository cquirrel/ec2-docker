resource "aws_ec2_instance_connect_endpoint" "eic" {
  subnet_id = aws_instance.web.subnet_id
}

resource "aws_security_group" "sg" {
  name        = "ec2_docker_sg"
  description = "Inbound/Outbound traffic rules"

  ingress {
    description      = "Allow SSH from EIC endpoint"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_ec2_instance_connect_endpoint.eic.security_group_ids[0]]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Nginx Proxy Manager UI"
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Portainer UI"
    from_port   = 9443
    to_port     = 9443
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
}