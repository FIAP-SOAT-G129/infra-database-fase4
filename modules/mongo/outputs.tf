
output "connection_string" {
  value = "mongodb://${vars.username}:${vars.password}@${mongodbatlas_advanced_cluster.free_cluster.connection_strings.standard_srv}/${vars.db_name}?authSource=admin"
}
