variable "host" {
  description = "The hostname of the PostgreSQL server"
  type        = string
}

variable "port" {
  description = "The port number of the PostgreSQL server"
  type        = number
  default     = 5432
}

variable "databases" {
  description = "Map of database names to their passwords"
  type = map(object({
    username = string
    password = string
  }))
}

