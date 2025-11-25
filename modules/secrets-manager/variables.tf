variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_host" {
  type        = string
  description = "Database host"
}

variable "db_port" {
  type        = number
  description = "Database port"
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
}
