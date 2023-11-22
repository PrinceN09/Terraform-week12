
resource "aws_instance" "web" {
  ami                                  = "ami-0230bd60aa48260c6"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  key_name                             = "ec2-demo"
  monitoring                           = false
  security_groups                      = ["launch-wizard-1"]
  subnet_id                            = "subnet-08d2464d8d3dbce7a"
  tags = {
    Name = "Imported server"
    env = "Dev"
    Team = "Devops"
 
  }
}
