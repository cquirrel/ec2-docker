data "aws_ec2_instance_type_offerings" "all" {
  location_type = "region"

  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }
}

# Pick free-tier eligible type: prefer t2.micro, fallback to t3.micro
locals {
  selected_type = contains(data.aws_ec2_instance_type_offerings.all.instance_types, "t2.micro") ? "t2.micro" : "t3.micro"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.selected_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  user_data = templatefile("${path.module}/cloud-init.yml", {
    PORTAINER_PASSWORD = var.portainer_password,
    NGINX_PROXY_MANAGER_EMAIL  = var.nginx_proxy_manager_email,
    NGINX_PROXY_MANAGER_PASSWORD  = var.nginx_proxy_manager_password
    INSTANCE_SWAP_SIZE = var.instance_swap_size
  })

  tags = {
    Name = "DockerHost"
  }
}