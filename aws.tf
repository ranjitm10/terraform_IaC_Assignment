variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  region     = "ap-south-1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}
resource "aws_key_pair" "edward-key" {
  key_name   = "edward-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDzyV5i9X+ms4VFficQvwyCVKkwDdYHnQQaDt5M7QyBr/8QTTvFCiCzRF9xKjpvDiLS8maWARl7O21f6/q/lFg7vktCq+1sd9kt0U15bkmztF6tsnEZN2u6hdg07+4nyLoQSHpAplEQho9je9WE0i57m0p9KfFSdveXpng+l0WIRuas/5uDvmZGlY0eoDo1jKtOJ+RdhuHaLqsWLN0BoH0I3LBeRaq11qeu9GkTP0C97M4HJCcSvP6rEhBq1QV/pj6RN70t7MlVoL1MtVbR9N2wo2wDur6P8sh0+WZ5batXXvXiCNrx+uaslbfIAtz9HFbgLkjWKnbLoSaFYC+wIRjZ mohit@DESKTOP-DEOJMQ5"
}
resource "aws_instance" "web" {
  ami                  = "ami-04b1ddd35fd71475a"
  instance_type        = "t2.micro"
  security_groups      = ["${aws_security_group.web-node.name}"]
  key_name             = aws_key_pair.edward-key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2-role.name
  tags = {
    Name = "Test instance"
  }
}
resource "aws_security_group" "web-node" {
  name        = "web-node"
  description = "Web Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

