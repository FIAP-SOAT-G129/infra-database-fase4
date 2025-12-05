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

variable "mongo_client_id" {
  description = "MongoDB Atlas Client ID"
  type        = string
}

variable "mongo_client_secret" {
  description = "MongoDB Atlas Client Secret"
  type        = string
}

variable "mongo_db_name" {
  description = "Name of the MongoDB database"
  type        = string
}

variable "mongo_username" {
  description = "Username for MongoDB database user"
  type        = string
}

variable "mongo_password" {
  description = "Password for MongoDB database user"
  type        = string
}

variable "tags" {
  description = "Tags padrão"
  type        = map(string)
  default     = {}
}

