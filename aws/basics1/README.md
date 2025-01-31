# AWS Basics 1 Terraform Configuration

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

This Terraform configuration is designed to set up foundational AWS infrastructure components, including a Virtual Private Cloud (VPC), subnets, and an EC2 instance. It serves as a basic example to demonstrate how to define and provision AWS resources using Terraform.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Installed on your local machine. Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) if needed.
- **AWS Account**: Active AWS account with programmatic access configured. Set up your AWS credentials using the AWS CLI or environment variables.

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/altairlage/terraform-studies-and-tests.git
   cd terraform-studies-and-tests/aws/basics1
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

5. **Access the EC2 Instance**:

   After the resources are provisioned, you can access the EC2 instance using SSH. Ensure you have the private key corresponding to the key pair specified in the configuration.

   ```bash
   ssh -i path/to/your-key.pem ec2-user@<EC2_Instance_Public_IP>
   ```

   Replace `<EC2_Instance_Public_IP>` with the public IP address of your EC2 instance, which can be found in the AWS Management Console or via the Terraform output.

6. **Destroy the Resources**:

   When you no longer need the infrastructure, destroy the resources to avoid incurring unnecessary costs.

   ```bash
   terraform destroy
   ```

   Confirm the prompt with `yes` to proceed.

## Configuration Details

The Terraform configuration in this folder includes the following components:

### Provider Configuration

```hcl
provider "aws" {
  region = var.region
}
```

### VPC

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  ...
}
```

### Subnets

```hcl
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  ...
}
```

### Security Group

```hcl
resource "aws_security_group" "ssh" {
  vpc_id = aws_vpc.main.id
  ...
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### EC2 Instance

```hcl
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  ...
}
```

## Variables

| Variable Name         | Description                         | Default Value       |
|-----------------------|-------------------------------------|---------------------|
| `region`              | AWS region for resource deployment  | `us-east-1`         |
| `vpc_cidr`            | CIDR block for the VPC              | `10.0.0.0/16`       |
| `public_subnet_cidr`  | CIDR block for the public subnet    | `10.0.1.0/24`       |
| `private_subnet_cidr` | CIDR block for the private subnet   | `10.0.2.0/24`       |
| `ami_id`              | AMI ID for the EC2 instance         | *Specify as needed* |
| `instance_type`       | EC2 instance type                   | `t2.micro`          |
| `key_name`            | Name of the SSH key pair            | *Specify as needed* |

## Outputs

| Output Name           | Description                         |
|-----------------------|-------------------------------------|
| `vpc_id`              | ID of the created VPC               |
| `public_subnet_id`    | ID of the public subnet             |
| `private_subnet_id`   | ID of the private subnet            |
| `ec2_instance_id`     | ID of the EC2 instance              |
| `ec2_instance_public_ip` | Public IP address of the EC2 instance |

These outputs provide useful information about the created resources and can be accessed after the Terraform apply process completes.
