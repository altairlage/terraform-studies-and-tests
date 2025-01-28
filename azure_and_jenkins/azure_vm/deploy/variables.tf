variable "build_server_name_prefix" {
    description = "Define the build server name to be used as resource name prefix"
    type        = string
    default     = "server1"
}

variable "location" {
    description = "Define the Azure location to be used"
    type        = string
    default     = "East US"
}

variable "networking_rg_name" {
    description = "Define the Azure networking resource group name to be used"
    type        = string
    default     = "networking-rg"
}

variable "vnet_name" {
    description = "Define the Azure vnet name to be used"
    type        = string
    default     = "acampos-vnet"
}

variable "subnet_name" {
    description = "Define the Azure subnet name to be used"
    type        = string
    default     = "acampos-subnet1"
}

variable "nsg_name" {
    description = "Define the Azure network security group name to be used"
    type        = string
    default     = "acampos-nsg1"
}

variable "build_servers_rg_name" {
    description = "Define the build servers resource group name to be used"
    type        = string
    default     = "vms-rg"
}

locals {
  default_tags = {
    createdBy = "Jenkins"
    source = "terraform"
  }
}