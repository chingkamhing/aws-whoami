variable "project" {
}

variable "region" {
}

variable "cidr_block" {
}

variable "public_subnets" {
}

variable "private_subnets" {
}

locals {
  azs = ["${var.region}a", "${var.region}b", "${var.region}c"]
}