resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public-subnet1.id
  vpc_security_group_ids = [aws_security_group.security-group.id]
  iam_instance_profile = aws_iam_instance_profile.instance-profile.name
  root_block_device {
    volume_size = 30
  }
  metadata_options {
    http_tokens = "required"
  }

  user_data = templatefile("./install-tools.sh", {})

  tags = {
    Name = var.instance_name
  }
  depends_on = [
    aws_subnet.public-subnet1,
    aws_security_group.security-group,
    aws_iam_instance_profile.instance-profile
  ]  
}
