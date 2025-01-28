terraform {
    backend "azurerm" {
        resource_group_name  = "rg-test-1"
        storage_account_name = "jenkinstfstate"
        container_name       = "terraform-state-container"
        key                  = "tftests-azure-vm1.tfstate"
    }
}