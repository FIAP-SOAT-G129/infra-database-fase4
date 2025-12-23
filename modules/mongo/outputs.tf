
output "connection_string" {
  value = "mongodb://${var.username}:${var.password}@${mongodbatlas_advanced_cluster.free_cluster.connection_strings.standard_srv}/${var.db_name}?authSource=admin"
}
