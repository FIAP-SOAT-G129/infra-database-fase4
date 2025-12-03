# Create Roles (Users)
resource "postgresql_role" "this" {
  for_each = var.databases

  name     = each.value.username
  password = each.value.password
  login    = true
}

# Create Databases
resource "postgresql_database" "this" {
  for_each = var.databases

  name              = each.key
  owner             = postgresql_role.this[each.key].name
  allow_connections = true
}

# Grant Permissions to Users
resource "postgresql_grant" "this" {
  for_each = var.databases

  database    = postgresql_database.this[each.key].name
  role        = postgresql_role.this[each.key].name
  object_type = "database"
  privileges  = ["CONNECT", "TEMPORARY"]
}
