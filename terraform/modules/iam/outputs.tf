output "iam_role_arn" {
  description = "The ARN of the IAM role created for the ECS task."
  value       = aws_iam_role.ecs_role.arn
}
