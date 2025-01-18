provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


resource "aws_instance" "web" {
  ami           = "ami-08970251d20e940b0"
  instance_type = "t2.micro"
  #availability_zone = "us-east-2c"
  subnet_id = "subnet-0f645fba34444ded8"
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = file("apache.sh")
  tags = {
    Name = "HelloWorld"
  }
}

