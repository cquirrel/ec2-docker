provider "aws" {}

terraform {
  backend "s3" {}
}

resource "aws_secretsmanager_secret" "portainer_password" {
  name        = "portainer/admin-password"
  description = "Admin password for Portainer"
}

resource "aws_secretsmanager_secret_version" "portainer_password_value" {
  secret_id     = aws_secretsmanager_secret.portainer_password.id
  secret_string = var.portainer_admin_password
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = file("~/.ssh/id_ed25519.pub")
# }