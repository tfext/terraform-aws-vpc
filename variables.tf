variable "name" {
  type        = string
  description = "VPC name"
}

variable "env" {
  type        = string
  default     = null
  description = "VPC environment (default is VPC name)"
}

variable "cidr_block" {
  type        = string
  description = "IPv4 CIDR"
}

variable "subnet_count" {
  type        = number
  default     = 3
  description = "Number of public and private subnets to create"
}

variable "multi_az_nat" {
  type        = bool
  default     = false
  description = "True to create a NAT in each AZ for failover support. This incurs more complex infrastructure and cost. Set to true for production VPCs"
}

variable "dhcp_domain_names" {
  type    = list(string)
  default = []
}

variable "subnet_group_cidr_bits" {
  type    = number
  default = 8
}

variable "subnet_cidr_bits" {
  type    = number
  default = 2
}

variable "private_subnet_offset" {
  type    = number
  default = 0
}

variable "public_subnet_offset" {
  type    = number
  default = 1
}
