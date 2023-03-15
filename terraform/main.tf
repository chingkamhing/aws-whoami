#
# terraform
#

terraform {
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.12.26"

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
