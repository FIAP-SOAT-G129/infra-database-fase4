variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
}

variable "instance" {
  type        = string
  description = "The instance type of the RDS instance"
  default     = "db.t3.micro"
}

variable "storage" {
  type        = number
  description = "The allocated storage in gigabytes"
  default     = 20
}

variable "databases" {
  description = "Map of databases to their credentials"
  type = map(object({
    username = string
    password = string
  }))
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the RDS instance"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS subnet group"
}

variable "tags" {
  type    = map(string)
  default = {}
}
