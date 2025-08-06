resource "aws_s3_bucket" "deploy_bucket" {
  bucket = "docker-images-bucket-243234234"

  tags = {
    Name = "DeployArtifacts"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.deploy_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}