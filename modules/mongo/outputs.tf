output "connection_string" {
  value = mongodbatlas_advanced_cluster.free_cluster.connection_strings.standard_srv
}
