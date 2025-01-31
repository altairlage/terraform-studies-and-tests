# Azure Storage Account Terraform Module

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

This Terraform module provisions an Azure Storage Account along with its associated resources, such as a Resource Group and Storage Containers. It is designed to facilitate the deployment of a Storage Account in Azure with customizable configurations.

## Usage

To utilize this module, include it in your Terraform configuration as follows:

```hcl
module "azure_storage_account" {
  source = "github.com/altairlage/terraform-studies-and-tests//azure_and_jenkins/azure_storage_account_test"

  # Define required variables here
  resource_group_name     = "example-resource-group"
  location                = "East US"
  storage_account_name    = "examplestorageacct"
  account_tier            = "Standard"
  account_replication_type = "LRS"
  # Add other variables as needed
}
```

Ensure that you replace the variable values with those appropriate for your environment.

## Variables

The module supports the following input variables:

| Name                     | Type   | Default | Description                                  |
|--------------------------|--------|---------|----------------------------------------------|
| `resource_group_name`    | string | n/a     | The name of the resource group               |
| `location`               | string | n/a     | The Azure region for the resources           |
| `storage_account_name`   | string | n/a     | The name of the Storage Account              |
| `account_tier`           | string | n/a     | The tier of the Storage Account              |
| `account_replication_type` | string | n/a   | The replication type of the Storage Account  |
| `enable_https_traffic_only` | bool | true   | Forces HTTPS if enabled                      |
| `min_tls_version`        | string | "TLS1_2" | The minimum supported TLS version            |

## Outputs

The module provides the following outputs:

| Name                     | Description                            |
|--------------------------|----------------------------------------|
| `storage_account_id`     | The ID of the Storage Account          |
| `storage_account_primary_endpoint` | The primary endpoint of the Storage Account |

## Requirements

- Terraform version 1.0 or higher
- Azure Provider version 2.0 or higher

## Providers

| Name    | Version |
|---------|---------|
| azurerm | >= 2.0  |

## Resources

This module creates the following resources:

| Name                                  | Type                      |
|---------------------------------------|---------------------------|
| `azurerm_resource_group.main`         | Resource Group            |
| `azurerm_storage_account.main`        | Storage Account           |
| `azurerm_storage_container.main`      | Storage Container         |

## Jenkins Pipeline Integration

Within the `infra` directory of this module, there is a `Jenkinsfile` that defines a Jenkins pipeline for automating the deployment of the Azure Storage Account infrastructure. The pipeline consists of the following stages:

1. **Initialization**: Sets up the environment and prepares for deployment.
2. **Terraform Initialization**: Initializes the Terraform configuration.
3. **Terraform Plan**: Creates an execution plan, allowing you to preview the changes that Terraform will make to your infrastructure.
4. **Terraform Apply**: Applies the changes required to reach the desired state of the configuration.

To utilize this Jenkins pipeline:

- Ensure that Jenkins is properly configured with the necessary plugins, such as the [Terraform Plugin](https://plugins.jenkins.io/terraform/).
- Configure Jenkins with the appropriate Azure credentials to allow Terraform to authenticate with your Azure subscription.
- Set up the pipeline in Jenkins to point to the `Jenkinsfile` located in the `infra` directory of this module.

For more detailed information on setting up Jenkins pipelines with Terraform and Azure, refer to the [Microsoft Learn documentation on implementing integration testing with Terraform and Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/best-practices-integration-testing).
