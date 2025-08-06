provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "tfstate-bucket-647200426149"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = file("~/.ssh/id_ed25519.pub")
# }