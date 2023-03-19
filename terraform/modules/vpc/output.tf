output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.main.id, "")
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.main.arn, "")
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.main.cidr_block, "")
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(aws_vpc.main.default_security_group_id, "")
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = try(aws_vpc.main.default_route_table_id, "")
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public_subnets[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public_subnets[*].cidr_block)
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private_subnets[*].arn
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private_subnets[*].cidr_block)
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.gateway.id, "")
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.gateway.arn, "")
}
