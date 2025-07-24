resource "aws_instance" "this" {
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu_server.id
  availability_zone           = data.aws_availability_zones.available.names[1]
  vpc_security_group_ids      = [aws_security_group.this.id]
  subnet_id                   = data.aws_subnets.public.ids[0]
  associate_public_ip_address = true
  key_name                    = var.ssh_key
  user_data                   = file("docker.sh")

  lifecycle {
    ignore_changes = [user_data]
  }

  root_block_device {
    volume_size = var.root_block_size
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.project_name}-${var.env}-${var.instance_name}"
    Project     = var.project_name,
    Environment = var.env
    Terraform   = true
  }
}

# resource "aws_eip" "this" {
#   instance = aws_instance.this.id
#   domain   = "vpc"

#   tags = {
#     Name        = "${var.instance_name}-EIP"
#     Project     = var.project_name,
#     Environment = var.env
#     Terraform   = true
#   }
# }
