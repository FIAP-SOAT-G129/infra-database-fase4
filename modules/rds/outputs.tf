output "address" {
  description = "The database address"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "The database port"
  value       = aws_db_instance.this.port
}
