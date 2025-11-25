resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    { Name = "${var.name}-rds-sg" }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = var.vpc_cidr_block
  from_port         = var.from_port
  to_port           = var.to_port
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.rds_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
