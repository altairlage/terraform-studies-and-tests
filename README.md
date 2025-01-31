# Terraform Studies and Tests

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

This repository contains various Terraform configurations and modules for studying and testing infrastructure as code on AWS and Azure platforms. Each module is documented with a README file that provides detailed instructions on usage, prerequisites, and configuration details.

## Modules

### [AWS Basics 1](aws/basics1/README.md)
This Terraform configuration is designed to set up foundational AWS infrastructure components, including a Virtual Private Cloud (VPC), subnets, and an EC2 instance. It serves as a basic example to get started with AWS using Terraform.

### [Instance Test 1](aws/instance-test1/README.md)
This Terraform module provisions an AWS EC2 instance with a customizable name tag. It is designed to be simple and reusable for creating EC2 instances in the `us-west-2` region.

### [Test Module 1](aws/test-module1/Readme.md)
This experimental Terraform module provides notes and testing guidelines for Terraform modules. It includes additional requirements and considerations for the directory structure.

### [VPC 1](aws/vpc1/README.md)
This Terraform module provisions a Virtual Private Cloud (VPC) in AWS with public and private subnets, along with associated networking components such as Network ACLs, Internet Gateway, and NAT Gateway.

### [VPC 2](aws/vpc2/README.md)
This Terraform module, **VPC2**, provisions a Virtual Private Cloud (VPC) in AWS. The module is designed to create a foundational network infrastructure with customizable configurations such as CIDR block, instance tenancy, and name tag.

### [Azure Virtual Machine](azure_and_jenkins/azure_vm/README.md)
This Terraform module provisions an Azure Virtual Machine (VM) along with its associated resources, such as a Virtual Network, Subnet, Network Interface, and Public IP. It is designed to facilitate the deployment of a VM in Azure.

### [Azure Storage Account](azure_and_jenkins/azure_storage_account_test/README.md)
This Terraform module provisions an Azure Storage Account along with its associated resources, such as a Resource Group and Storage Containers. It is designed to facilitate the deployment of a Storage Account in Azure.

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.