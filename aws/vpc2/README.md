
# Terraform Module: VPC2

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Configuration Details](#configuration-details)
- [Built-in Verification and Checks](#built-in-verification-and-checks)
- [Variables](#variables)
- [Outputs](#outputs)

## Overview

This Terraform module, **VPC2**, provisions a **Virtual Private Cloud (VPC)** in AWS. The module is designed to create a foundational network infrastructure with customizable configurations such as the AWS region, CIDR block, and VPC name. It uses the AWS provider to define and manage the VPC resource.

### Key Features:
- **VPC**: Creates a VPC with a customizable CIDR block and name tag.
- **AWS Region**: Allows you to specify the AWS region where the VPC will be deployed.
- **Input Validation**: Ensures that inputs like region, CIDR block, and VPC name adhere to specific formats and conventions.
- **Built-in Verification**: Includes steps to validate and test the Terraform configuration using built-in tools.

## Prerequisites

Before you begin, ensure you have the following:

- **Terraform**: Installed on your local machine. Follow the [official installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) if needed.
- **AWS Account**: Active AWS account with programmatic access configured. Set up your AWS credentials using the AWS CLI or environment variables.

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/your-repo/terraform-vpc2-module.git
   cd terraform-vpc2-module
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
The module uses the AWS provider, configured to deploy resources in a customizable AWS region. The default AWS profile is used for authentication. The AWS provider version is pinned to `~> 3.43` to ensure compatibility.

### VPC
A VPC is created with the following configurations:
- **CIDR Block**: The IP address range for the VPC is customizable, with a default value of `10.0.0.0/18`. The CIDR block is validated to ensure it is in a valid format and within the acceptable range (`/16` to `/28`).
- **Instance Tenancy**: The VPC uses the default tenancy model, meaning instances launched in the VPC run on shared hardware.
- **Name Tag**: The VPC is tagged with a customizable name, which defaults to `"WGinfrastructure"`. The name is validated to ensure it adheres to a good naming convention (alphanumeric characters and hyphens are allowed).

### Input Validation
The module includes validation rules for the following inputs:
- **Region**: Ensures the AWS region is in a valid format (e.g., `us-west-2`).
- **CIDR Block**: Ensures the CIDR block is in a valid format and within the acceptable range (`/16` to `/28`).
- **VPC Name**: Ensures the VPC name adheres to a good naming convention (alphanumeric characters and hyphens are allowed).

## Built-in Verification and Checks

To ensure the Terraform configuration is valid and adheres to best practices, the module includes built-in verification and checks. These steps can be automated or run manually:

### File Structure
The module follows a structured approach to validation:
1. **`main.tf`**: Contains the basic template for the VPC configuration. This file is non-editable to ensure consistency.
2. **`variables.tf`**: Contains input variables with validation rules. This file is also non-editable to enforce proper input validation.
3. **`terraform.tfvars`**: Allows users to specify their desired variables. This file is editable and is used to pass values to the module.

### Validation Steps
After creating or updating the configuration files (`main.tf`, `variables.tf`, and `terraform.tfvars`), run the following commands to validate and test the configuration:

1. **Format Check**:
   Ensures the Terraform files are properly formatted.
   ```bash
   terraform fmt -check
   ```

2. **Validate Configuration**:
   Validates the Terraform configuration for syntax and consistency.
   ```bash
   terraform validate -json
   ```

3. **Execution Plan**:
   Generates an execution plan to preview the changes Terraform will make.
   ```bash
   terraform plan
   ```

These steps can be scripted to automate the validation process, ensuring that the configuration is always checked before applying changes.

## Variables

The module uses the following input variables to customize the infrastructure:

| Variable Name   | Description                         | Default Value       |
|-----------------|-------------------------------------|---------------------|
| `region`        | AWS region where the VPC will be deployed. Must be in a valid format (e.g., `us-west-2`). | `us-west-2`         |
| `cidr_block`    | CIDR block for the VPC. Must be in a valid format (e.g., `10.0.0.0/18`) and within the range `/16` to `/28`. | `10.0.0.0/18`       |
| `tags`          | Name tag for the VPC. Must adhere to a good naming convention (alphanumeric characters and hyphens are allowed). | `"WGinfrastructure"` |

## Outputs

The module can be configured to output useful information about the created resources. These outputs are helpful for referencing resources in other Terraform configurations or for debugging purposes. Below are the potential outputs that can be added:

1. **VPC ID**: The ID of the created VPC. This output is useful for referencing the VPC in other modules or configurations.
2. **VPC CIDR Block**: The CIDR block of the created VPC. This output can be used to verify the VPC's IP address range.
3. **VPC Name**: The name tag of the created VPC. This output is useful for identifying the VPC in the AWS Management Console or other tools.

These outputs are not defined by default in the module but can be added as needed to provide visibility into the created resources.
```



# Old instructions


Builtin verification, and checks:

terraform ftm --check

terraform validate --json

terraform plan 

One way in which we can validate and test a main.tf is to leave that file with the basic template information and make it non-editable and then create two additional files one named variables.tf (also non-editable) that include validation checks and information, and another with extension .tfvars <terraform.tfvars> which a user can edit to place their desired variables to be used after which  :

After creation of main.tf, variables.tf, and terraform.tfvars, do the following to validate (which can be scripted.)
$ terraform fmt -check

$ terraform validate -json 

$ terraform plan



After running those tests/checks and if no errors were generated it would be safe to run..

$ terraform plan -out <plan.tf>

$ terraform apply <plan.tf>
