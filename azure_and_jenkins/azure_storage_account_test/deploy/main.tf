terraform {
    required_providers {
        azurerm =   {
            source  = "hashicorp/azurerm"
            
        }
    }
}

provider "azurerm" {
    version = "~> 3.0"
    features {}
}

resource "azurerm_resource_group" "rg" {
    name        = var.rgVars["name"]
    location    = var.rgVars["location"]
}

#
# - Create a Random string to append to Storage account name
#
resource "random_string" "sa_name" {
   length   =   5
   special  =   false
   lower    =   true
   upper    =   false
   number   =   false
}

resource "azurerm_storage_account" "sa" {
    count                         = var.saCount
    name                          = "sa${random_string.sa_name.result}${count.index+1}"
    resource_group_name           = azurerm_resource_group.rg.name
    location                      = azurerm_resource_group.rg.location
    account_tier                  = var.saVars["account_tier"]
    account_replication_type      = var.saVars["account_replication_type"]
}

resource "azurerm_storage_container" "sc" {
    count                         =     var.saCount
    name                          =     var.saVars["container_name"]
    storage_account_name          =     element(azurerm_storage_account.sa.*.name, count.index)
    container_access_type         =     var.saVars["container_access_type"]
}