variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-cluster"
}


variable "execution_role_arn" {
  description = "The ARN of the IAM role that the ECS task will assume"
  type        = string
}


variable "container_image" {
  description = "The Docker image to use for the ECS task"
  type        = string
}


variable "subnet_ids" {
  description = "A list of subnet IDs for the ECS service"
  type        = list(string)
}


variable "vpc_id" {
  description = "The ID of the VPC where the ECS service will be deployed"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}
