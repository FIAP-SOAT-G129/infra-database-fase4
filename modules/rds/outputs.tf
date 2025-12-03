output "address" {
  description = "The database instance address"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "The database instance port"
  value       = aws_db_instance.this.port
}
