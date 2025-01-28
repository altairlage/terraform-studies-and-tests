terraform {
    required_providers {
        azurerm =   {
            source  = "hashicorp/azurerm"
            version = "~> 3.0"
        }
        random = {
            source  = "hashicorp/random"
            version = "~>3.0"
        }
    }
}

provider "azurerm" {
    features {}
}

# Data about existing resources in the azure subscription

data "azurerm_resource_group" "networking_rg" {
    name = var.networking_rg_name
}

data "azurerm_virtual_network" "build_servers_vnet" {
    name                = var.vnet_name
    resource_group_name = data.azurerm_resource_group.networking_rg.name
}

data "azurerm_subnet" "build_servers_subnet" {
    name                 = var.subnet_name
    virtual_network_name = data.azurerm_virtual_network.build_servers_vnet.name
    resource_group_name  = data.azurerm_resource_group.networking_rg.name
}

data "azurerm_network_security_group" "build_servers_nsg" {
    name                = var.nsg_name
    resource_group_name = data.azurerm_resource_group.networking_rg.name
}

# VM related resources

data "azurerm_resource_group" "build_servers_rg" {
    name = var.build_servers_rg_name
}

# Create public IPs - to be removed after tests!!
resource "azurerm_public_ip" "build_server_public_ip" {
    name                = "${var.build_server_name_prefix}-public-ip"
    location            = data.azurerm_resource_group.build_servers_rg.location
    resource_group_name = data.azurerm_resource_group.build_servers_rg.name
    allocation_method   = "Dynamic"

    tags = local.default_tags
}

# Create network interface
resource "azurerm_network_interface" "build_server_nic" {
    name                = "${var.build_server_name_prefix}-nic"
    location            = var.location
    resource_group_name = data.azurerm_resource_group.build_servers_rg.name

    ip_configuration {
        name                          = "build_server_nic_config"
        subnet_id                     = data.azurerm_subnet.build_servers_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.build_server_public_ip.id
    }

    tags = local.default_tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "build_server_nic_sg_assoc" {
    network_interface_id      = azurerm_network_interface.build_server_nic.id
    network_security_group_id = data.azurerm_network_security_group.build_servers_nsg.id
}

# Create build server VM
resource "azurerm_windows_virtual_machine" "build_server_vm" {
    name                  = "${var.build_server_name_prefix}-vm"
    # cannot match: "administrator, admin, user, user1, test, user2, test1, user3, admin1, 1, 123, a, actuser, adm, admin2, aspnet, backup, console, david, guest, john, owner, root, server, sql, support, support_388945a0, sys, test2, test3, user4, user5"
    admin_username        = "azure_admin"
    admin_password        = random_password.password.result
    location              = var.location
    resource_group_name   = data.azurerm_resource_group.build_servers_rg.name
    network_interface_ids = [azurerm_network_interface.build_server_nic.id]
    size                  = "Standard_DS1_v2" #official one will be Standard D2s v3 (2 vcpus, 8 GiB memory)

    tags = local.default_tags

    os_disk {
        name                 = "${var.build_server_name_prefix}-OsDisk"
        caching              = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2022-datacenter-azure-edition"
        version   = "latest"
    }
}

# Generate a random password for the vm user
resource "random_password" "password" {
    length      = 20
    min_lower   = 1
    min_upper   = 1
    min_numeric = 1
    min_special = 1
    special     = true
}