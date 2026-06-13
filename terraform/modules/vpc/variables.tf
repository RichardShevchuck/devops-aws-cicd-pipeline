variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "cidr_block1" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "cidr_block2" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}
