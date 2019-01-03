provider "aws" {
  region = "us-east-1"
}
resource "aws_key_pair" "deployer" {
  key_name   = "us-east-1-windows"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDcOETTi0uHVRvHRPdTk9clYiPxjyXZWXEdG49wr77bIFLNgI9rrZfE8WXCN6DdOZxLqaTMHZHG4Syjr/dAofKqVOgQooY0Vtw7uRnifOEA4JtkXHeDV/Dc/hUfvsiBH+4M6XM1K4UKPN1fAErvSDoC/yPadA5Izvq4nMwjAqzRnJu+168sKBSziF9VsVLuVGnf2k/dcvOrrVDn3URkkHuok/MBe2WwwkHf8H2Yzuhv6Ohv+h5J1j+Xvpp65KWxdFF6+O52HImR6mPxf8zQisdVBQdmPWyZCTui6P0F98hkBtBH8b/rrZnGGP+guVyRJBDi8A9Tx/figAbgg2/GGVPx"
}

resource "aws_instance" "example" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
  
tags {
    Name = "terraform-example"
  }
}
