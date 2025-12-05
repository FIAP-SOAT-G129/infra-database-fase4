resource "aws_secretsmanager_secret" "dbs_credentials" {
  for_each = var.connections_details

  name        = "${var.name}-${each.key}-db-secrets"
  description = "Database credentials for ${each.key} database"

  recovery_window_in_days = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-${each.key}-db-secrets" }
  )
}

resource "aws_secretsmanager_secret_version" "dbs_credentials_version" {
  for_each = var.connections_details

  secret_id = aws_secretsmanager_secret.dbs_credentials[each.key].id
  secret_string = jsonencode({
    db_host     = each.value.host
    db_port     = each.value.port
    db_name     = each.value.db_name
    db_username = each.value.username
    db_password = each.value.password
  })
}

resource "aws_secretsmanager_secret" "mongo_connection" {
  name        = "${var.name}-orders-db-secrets"
  description = "MongoDB connection string for orders database"

  recovery_window_in_days = 0

  tags = merge(
    var.tags,
    { Name = "${var.name}-orders-db-secrets" }
  )

}

resource "aws_secretsmanager_secret_version" "mongo_connection_version" {
  secret_id = aws_secretsmanager_secret.mongo_connection.id
  secret_string = jsonencode({
    connection_string = var.mongo_connection_details.connection_string
    db_name           = var.mongo_connection_details.db_name
    db_username       = var.mongo_connection_details.username
    db_password       = var.mongo_connection_details.password
  })
}

