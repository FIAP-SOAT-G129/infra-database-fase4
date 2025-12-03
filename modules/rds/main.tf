resource "aws_db_instance" "this" {
  identifier        = "${var.name}-db"
  allocated_storage = var.storage
  engine            = data.aws_rds_engine_version.postgres.engine
  engine_version    = data.aws_rds_engine_version.postgres.version
  instance_class    = var.instance

  username = var.master_username
  password = var.master_password

  parameter_group_name    = data.aws_db_parameter_group.postgres.name
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = var.security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  backup_retention_period = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-db" }
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
