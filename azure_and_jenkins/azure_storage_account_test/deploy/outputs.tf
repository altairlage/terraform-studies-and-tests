output "storage_account_name" {
    description    =    "Name of the storage accounts"
    value          =    azurerm_storage_account.sa.*.name
}

output "storage_container_name" {
    description    =    "Name of the storage containers"
    value          =    azurerm_storage_container.sc.*.name
}
