resource "aws_db_instance" "this" {
  identifier              = "${var.name}-${var.db_name}"
  allocated_storage       = var.storage
  engine                  = data.aws_rds_engine_version.postgres.engine
  engine_version          = data.aws_rds_engine_version.postgres.version
  instance_class          = var.instance
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  parameter_group_name    = data.aws_db_parameter_group.postgres.name
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  backup_retention_period = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-fastfood-db" }
  )
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-rds-subnets"
  subnet_ids = var.subnet_ids

  tags = merge(
    var.tags,
    { Name = "${var.name}-rds-subnets" }
  )
}
