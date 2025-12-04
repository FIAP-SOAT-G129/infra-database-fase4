variable "name" {
  description = "Nome base para recursos"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "databases" {
  description = "Map of database names to their credentials"
  type = map(object({
    username = string
    password = string
  }))
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}

