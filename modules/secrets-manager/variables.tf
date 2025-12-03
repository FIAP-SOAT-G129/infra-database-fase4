variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
}

variable "db_master_username" {
  description = "Database master username"
  type        = string
}

variable "db_master_password" {
  description = "Database master password"
  type        = string
}

variable "databases" {
  description = "Map of database names to their passwords"
  type = map(object({
    username = string
    password = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
