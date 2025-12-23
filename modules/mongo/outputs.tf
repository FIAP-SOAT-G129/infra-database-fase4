output "connection_string" {
  value = "mongodb+srv://${var.username}:${var.password}@${replace(
    mongodbatlas_advanced_cluster.free_cluster.connection_strings.standard_srv,
    "mongodb+srv://",
    ""
  )}/${var.db_name}?authSource=admin"
  sensitive = true
}
