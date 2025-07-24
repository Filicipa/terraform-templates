resource "aws_security_group" "this" {
  name   = "${var.project_name}-${var.env}-${var.instance_name}-sg"
  vpc_id = data.aws_vpc.selected.id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.project_name}-${var.env}-${var.instance_name}-sg"
    Project     = var.project_name
    Environment = var.env
    Terraform   = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "tcp_ports" {
  count             = length(var.tcp_ports)
  from_port         = element(var.tcp_ports, count.index)
  to_port           = element(var.tcp_ports, count.index)
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.this.id
  description       = "Allow TCP port"
}

resource "aws_vpc_security_group_ingress_rule" "udp_ports" {
  count             = length(var.udp_ports)
  from_port         = element(var.udp_ports, count.index)
  to_port           = element(var.udp_ports, count.index)
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.this.id
  description       = "Allow UDP port"
}

resource "aws_vpc_security_group_ingress_rule" "access_from_vpc" {
  security_group_id = aws_security_group.this.id
  description       = "Allow connecting from VPC"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "all"
  cidr_ipv4         = data.aws_vpc.selected.cidr_block
}

resource "aws_vpc_security_group_egress_rule" "access_to_anywhere" {
  security_group_id = aws_security_group.this.id
  description       = "Allow outbound traffic"
  from_port         = -1
  to_port           = -1
  ip_protocol       = "all"
  cidr_ipv4         = "0.0.0.0/0"
}
