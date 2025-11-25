variable "name" {
  description = "Nome base para recursos"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}

