# Resource Group
variable "rgVars" {
    description =   "Resource group variables"
    type        =   map(string)
    default     =   {
        "name"      =   "Storage-Rg"
        "location"  =   "East US"    
    }
}


# Storage account

variable "saCount" {
    default     =   2
}

variable "saVars" {
    description  =  "Variables for Storage accounts and containers"
    type         =  map(string)
    default      =  {
        "account_tier"                  =    "Standard"
        "account_replication_type"      =    "LRS"
        "container_name"                =    "diagnostics"
        "container_access_type"         =    "private"
    }
}