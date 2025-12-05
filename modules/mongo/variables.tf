variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "SA_EAST_1"
}

variable "project_name" {
  description = "Name of the MongoDB Atlas project"
  type        = string
}

variable "org_id" {
  description = "Organization ID for MongoDB Atlas"
  type        = string
}

variable "cluster_name" {
  description = "Name of the MongoDB Atlas cluster"
  type        = string
}

variable "username" {
  description = "Username for the MongoDB database user"
  type        = string
}

variable "password" {
  description = "Password for the MongoDB database user"
  type        = string
}

variable "db_name" {
  description = "Name of the MongoDB database"
  type        = string
}
