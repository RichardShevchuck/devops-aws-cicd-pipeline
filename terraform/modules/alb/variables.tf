variable "vpc_id" {
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}


variable "environment" {
  description = "The environment for the ALB (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}


variable "subnet_ids" {
  description = "A list of subnet IDs for the ALB"
  type        = list(string)
}
