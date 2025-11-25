data "aws_rds_engine_version" "postgres" {
  engine  = "postgres"
  version = "17.4"
}

data "aws_db_parameter_group" "postgres" {
  name = "default.postgres17"
}
