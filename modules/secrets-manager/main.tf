resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.name}-db-secrets"
  description = "Database credentials for RDS instance"

  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    db_name     = var.db_name
    db_host     = var.db_host
    db_port     = var.db_port
    db_username = var.db_username
    db_password = var.db_password
  })
}
