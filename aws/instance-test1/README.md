
# instance-test1

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

This Terraform module provisions an AWS EC2 instance with a customizable name tag. It is designed to be simple and reusable for creating EC2 instances in the `us-west-2` region.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Installed on your local machine. Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) if needed.
- **AWS Account**: Active AWS account with programmatic access configured. Set up your AWS credentials using the AWS CLI or environment variables.

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/your-repo/terraform-instance-test1.git
   cd terraform-instance-test1
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
  profile = "default"
  region  = "us-west-2"
}
```

### EC2 Instance

```hcl
resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
```

### Variables

```hcl
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "WGExampleInstance"

  validation {
    condition     = can(regex("^([a-zA-Z0-9])+$", var.instance_name))
    error_message = "Must be a valid instance name, can contain letters and numbers."
  }
}
```

### Outputs

```hcl
output "instance_name" {
  value = var.instance_name
}
```

## Variables

| Variable Name         | Description                         | Default Value       |
|-----------------------|-------------------------------------|---------------------|
| `instance_name`       | Value of the Name tag for the EC2 instance. Must contain only letters and numbers. | `"WGExampleInstance"` |

## Outputs

| Output Name           | Description                         |
|-----------------------|-------------------------------------|
| `instance_name`       | The name of the EC2 instance.       |

These outputs provide useful information about the created resources and can be accessed after the Terraform apply process completes.
```

### Key Changes:
1. **Structure**: Followed the same structure as your provided `README.md`, including sections like **Overview**, **Prerequisites**, **Usage**, **Configuration Details**, **Variables**, and **Outputs**.
2. **Content**: Adapted the content to match the `instance-test1` module, focusing on the EC2 instance provisioning.
3. **License Badge**: Added the MIT license badge at the top, similar to your example.
