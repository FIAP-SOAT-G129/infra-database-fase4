output "db_names" {
  description = "The names of the database instances"
  value       = { for k, v in aws_db_instance.this : k => v.db_name }
}

output "addresses" {
  description = "The database instance address"
  value       = { for k, v in aws_db_instance.this : k => v.address }
}

output "ports" {
  description = "The database instance ports"
  value       = { for k, v in aws_db_instance.this : k => v.port }
}
