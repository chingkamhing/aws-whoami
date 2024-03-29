output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(module.vpc.vpc_id, "")
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(module.vpc.vpc_arn, "")
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(module.vpc.vpc_cidr_block, "")
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(module.vpc.default_security_group_id, "")
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = try(module.vpc.default_route_table_id, "")
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(module.vpc.public_subnets_cidr_blocks)
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.vpc.private_subnet_arns
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = try(module.vpc.internet_gateway_id, "")
}

output "internet_gateway_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(module.vpc.internet_gateway_arn, "")
}

output "ec2_ami_id" {
  description = "The AMI of the EC2"
  value       = try(data.aws_ami.amzlinux.id, "")
}

output "ec2_ami_name" {
  description = "The name of the EC2"
  value       = try(data.aws_ami.amzlinux.name, "")
}
