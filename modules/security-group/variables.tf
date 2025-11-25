variable "name" {
  type        = string
  description = "Base name for resources"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to deploy resources in"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "from_port" {
  type        = number
  description = "The starting port for the security group rule"
  default     = 5432
}

variable "to_port" {
  type        = number
  description = "The ending port for the security group rule"
  default     = 5432
}

variable "tags" {
  type    = map(string)
  default = {}
}
