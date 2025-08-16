provider "aws" {
}

terraform {
  backend "s3" {
    key = "terraform.tfstate"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}