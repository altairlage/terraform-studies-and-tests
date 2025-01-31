
# Terraform Module: VPC with Public and Private Subnets

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Configuration Details](#configuration-details)
- [Variables](#variables)
- [Outputs](#outputs)

## Overview

This Terraform module provisions a **Virtual Private Cloud (VPC)** in AWS with **public and private subnets**, along with associated networking components such as **Network ACLs**, **Internet Gateway**, **NAT Gateway**, and **Route Tables**. The module is designed to create a secure and scalable network infrastructure in the `ap-southeast-2` (Sydney) region.

### Key Features:
- **VPC**: A VPC is created with a customizable CIDR block, allowing you to define the IP address range for your network.
- **Subnets**: Public and private subnets are provisioned in different availability zones, ensuring high availability and fault tolerance.
- **Network ACLs**: Network ACLs are configured for both public and private subnets to control inbound and outbound traffic, enhancing security.
- **Internet Gateway**: An Internet Gateway is attached to the VPC, enabling instances in the public subnet to access the internet.
- **NAT Gateway**: A NAT Gateway is provisioned in the public subnet, allowing instances in the private subnet to access the internet while remaining secure.
- **Route Tables**: Route tables are configured for public and private subnets, ensuring proper routing of traffic between subnets and the internet.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Installed on your local machine. Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) if needed.
- **AWS Account**: Active AWS account with programmatic access configured. Set up your AWS credentials using the AWS CLI or environment variables.

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/your-repo/terraform-vpc-module.git
   cd terraform-vpc-module
   ```

2. **Initialize Terraform**:

   Initialize the Terraform working directory, which will download the necessary provider plugins.

   ```bash
   terraform init
   ```

3. **Review the Configuration**:

   It's good practice to review the execution plan before applying changes.

   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:

   Apply the Terraform configuration to create the defined AWS resources.

   ```bash
   terraform apply
   ```

   Confirm the prompt with `yes` to proceed.

5. **Destroy the Resources**:

   When you no longer need the infrastructure, destroy the resources to avoid incurring unnecessary costs.

   ```bash
   terraform destroy
   ```

   Confirm the prompt with `yes` to proceed.

## Configuration Details

### Provider Configuration
The module uses the AWS provider, configured to deploy resources in the `ap-southeast-2` region. The default AWS profile is used for authentication.

### VPC
A VPC is created with a customizable CIDR block. The VPC serves as the foundation for the network infrastructure, providing isolation for your AWS resources.

### Subnets
The module creates two types of subnets:
- **Public Subnet**: This subnet is designed for resources that need direct internet access, such as web servers. It is associated with a route table that routes traffic through an Internet Gateway.
- **Private Subnet**: This subnet is designed for resources that do not require direct internet access, such as databases. It is associated with a route table that routes traffic through a NAT Gateway.

### Network ACLs
Network ACLs (NACLs) are configured for both public and private subnets. NACLs act as a firewall for controlling traffic at the subnet level. The module defines rules to allow specific types of traffic (e.g., HTTP traffic on port 80) while blocking others.

### Internet Gateway
An Internet Gateway is attached to the VPC, enabling instances in the public subnet to communicate with the internet. It also allows internet-based users to access resources in the public subnet.

### NAT Gateway
A NAT Gateway is provisioned in the public subnet. It allows instances in the private subnet to access the internet for updates or external services while preventing unsolicited inbound traffic.

### Route Tables
Route tables are configured to control how traffic is routed within the VPC:
- **Public Route Table**: Routes traffic from the public subnet to the Internet Gateway.
- **Private Route Table**: Routes traffic from the private subnet to the NAT Gateway.

## Variables

The module uses the following input variables to customize the infrastructure:

| Variable Name               | Description                         | Default Value       |
|-----------------------------|-------------------------------------|---------------------|
| `cidr_block`                | CIDR block for the VPC              | `10.0.0.0/18`       |
| `tags`                      | Name tag for the VPC                | `"main-tf"`         |
| `public_subnet_tag`         | Name tag for the public subnet      | `"Public-Subnet"`   |
| `private_subnet_tag`        | Name tag for the private subnet     | `"Private-Subnet"`  |
| `public_subnet_cidr_block`  | CIDR block for the public subnet    | `10.0.1.0/24`       |
| `private_subnet_cidr_block` | CIDR block for the private subnet   | `10.0.2.0/24`       |
| `public_subnet_az`          | Availability zone for public subnet | `"ap-southeast-2a"` |
| `private_subnet_az`         | Availability zone for private subnet| `"ap-southeast-2b"` |

## Outputs

The module can be configured to output useful information about the created resources. These outputs are helpful for referencing resources in other Terraform configurations or for debugging purposes. Below are the potential outputs that can be added:

1. **VPC ID**: The ID of the created VPC. This output is useful for referencing the VPC in other modules or configurations.
2. **Public Subnet ID**: The ID of the public subnet. This output can be used to deploy resources like EC2 instances or load balancers in the public subnet.
3. **Private Subnet ID**: The ID of the private subnet. This output is useful for deploying resources like databases or internal services in the private subnet.
4. **NAT Gateway IP**: The public IP address associated with the NAT Gateway. This output can be used to verify the NAT Gateway's configuration or for debugging purposes.
5. **Internet Gateway ID**: The ID of the Internet Gateway attached to the VPC. This output is useful for verifying the VPC's internet connectivity configuration.

These outputs are not defined by default in the module but can be added as needed to provide visibility into the created resources.
```
