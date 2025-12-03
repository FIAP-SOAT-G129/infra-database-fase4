variable "name" {
  description = "Base name for resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy resources in"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "from_port" {
  description = "The starting port for the security group rule"
  type        = number
  default     = 5432
}

variable "to_port" {
  description = "The ending port for the security group rule"
  type        = number
  default     = 5432
}

variable "tags" {
  type    = map(string)
  default = {}
}
