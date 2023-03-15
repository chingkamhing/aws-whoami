#
# variables
#

variable "project" {
  description = "Project name"
  type        = string
  default     = "whoami"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "ap-southeast-1"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "VPC public subnet CIDR block"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "VPC private subnet CIDR block"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}
