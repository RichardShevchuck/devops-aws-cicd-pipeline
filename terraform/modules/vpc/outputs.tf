output "vpc_id" {
  description = "The ID of the VPC created."
  value       = aws_vpc.vpc.id
}


output "public_subnet_ids" {
  description = "The IDs of the public subnets created."
  value       = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
}
