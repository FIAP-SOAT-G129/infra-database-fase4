variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "connections_details" {
  description = "Map of database names to their connection details"
  type = map(object({
    host     = string
    port     = number
    db_name  = string
    username = string
    password = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
