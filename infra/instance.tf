resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]

  user_data = templatefile("${path.module}/cloud-init.yml", {
    portainer_password = var.portainer_password,
    nginx_proxy_manager_email  = var.nginx_proxy_manager_email,
    nginx_proxy_manager_password  = var.nginx_proxy_manager_password
  })

  tags = {
    Name = "DockerHost"
  }
}
