#
# terraform
#

terraform {
  required_version = ">= 0.13"

  backend "s3" {
    bucket         = "whoami-bucket"
    key            = "terraform/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "whoami-lock-table"
  }
}

#
# provider
#

provider "aws" {
  region = var.region
}

#
# VPC
#

module "vpc" {
  source = "./modules/vpc"

  project         = var.project
  region          = var.region
  cidr_block      = var.cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
