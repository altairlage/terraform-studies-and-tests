terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.43"
    }
  }
}
 
provider "aws" {
  profile = "default"
  region = var.region
}
 
resource "aws_vpc" "wg-infrastructure" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  tags = {
    Name = var.tags
  }
}
