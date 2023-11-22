resource "aws_iam_group" "group1" {
  name = "DevOps"
}

resource "aws_instance" "name" {
  ami           = data.aws_ami.ami1.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.example.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./week12b.pem")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo hello"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum uodate -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "mkdir prince",
      "pwd",
      "nproc"
    ]

  }
  provisioner "file" {
    source      = "week12b.pem"
    destination = "/tmp/w.pem"
  }
    depends_on = [aws_key_pair.ec2_key, aws_iam_group.group1]

}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Allow inbound traffic on port 80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from any source. For production, you might want to restrict this to specific IP ranges.
  }
}
