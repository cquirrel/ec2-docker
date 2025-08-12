resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  #key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = file("cloud-init-processed.yml")

  tags = {
    Name = "DockerHost"
  }
}
