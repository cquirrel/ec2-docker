provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {}
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = file("~/.ssh/id_ed25519.pub")
# }