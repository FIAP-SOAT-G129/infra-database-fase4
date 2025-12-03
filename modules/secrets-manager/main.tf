# Master credentials
resource "aws_secretsmanager_secret" "db_master_credentials" {
  name        = "${var.name}-db-secrets"
  description = "Database credentials for RDS instance"

  recovery_window_in_days = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-db-master-secrets" }
  )
}

resource "aws_secretsmanager_secret_version" "db_master_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_master_credentials.id
  secret_string = jsonencode({
    db_host     = var.db_host
    db_port     = var.db_port
    db_username = var.db_master_username
    db_password = var.db_master_password
  })
}

# Databases credentials
resource "aws_secretsmanager_secret" "dbs_credentials" {
  for_each = var.databases

  name        = "${var.name}-${each.key}-db-secrets"
  description = "Database credentials for ${each.key} database"

  recovery_window_in_days = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-${each.key}-db-secrets" }
  )
}

resource "aws_secretsmanager_secret_version" "dbs_credentials_version" {
  for_each = var.databases

  secret_id = aws_secretsmanager_secret.dbs_credentials[each.key].id
  secret_string = jsonencode({
    db_name     = each.key
    db_host     = var.db_host
    db_port     = var.db_port
    db_username = each.value.username
    db_password = each.value.password
  })
}

