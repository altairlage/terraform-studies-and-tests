output "build_servers_rg_id" {
    value = data.azurerm_resource_group.build_servers_rg.id
}

output "build_servers_vnet_id" {
    value = data.azurerm_virtual_network.build_servers_vnet.id
}

output "build_servers_subnet_id" {
    value = data.azurerm_subnet.build_servers_subnet.id
}

output "vm_password" {
    sensitive = true
    value = random_password.password.result
}

output "public_ip_address" {
    value = azurerm_windows_virtual_machine.build_server_vm.public_ip_address
}

output "admin_password" {
    sensitive = true
    value     = azurerm_windows_virtual_machine.build_server_vm.admin_password
}