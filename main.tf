provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name = "deployer-key"

user_data= <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
    
tags {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
    description = "The port the server will use for HTTP requests"

}	

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcOETTi0uHVRvHRPdTk9clYiPxjyXZWXEdG49wr77bIFLNgI9rrZfE8WXCN6DdOZxLqaTMHZHG4Syjr/dAofKqVOgQooY0Vtw7uRnifOEA4JtkXHeDV/Dc/hUfvsiBH+4M6XM1K4UKPN1fAErvSDoC/yPadA5Izvq4nMwjAqzRnJu+168sKBSziF9VsVLuVGnf2k/dcvOrrVDn3URkkHuok/MBe2WwwkHf8H2Yzuhv6Ohv+h5J1j+Xvpp65KWxdFF6+O52HImR6mPxf8zQisdVBQdmPWyZCTui6P0F98hkBtBH8b/rrZnGGP+guVyRJBDi8A9Tx/figAbgg2/GGVPx"
} 
