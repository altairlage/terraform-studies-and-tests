variable "cidr_block" {
    description = "define the cidr_block for vpc"
    type = string
    default = "10.0.0.0/18"
}
 
variable "tags" {
    description = "set the name for vpc"
    type = string
    default = "main-tf"
}

variable "public_subnet_tag" {
    default = "Public-Subnet"
}

variable "private_subnet_tag" {
    default = "Private-Subnet"
}

variable "DMZ_subnet_tag" {
    default = "DMZ-Subnet"
}
 
variable "public_subnet_cidr_block" {
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
    default = "10.0.2.0/24"
}

variable "DMZ_subnet_cidr_block" {
    default = "10.0.3.0/24"
}

variable "public_subnet_az" {
    default = "ap-southeast-2a"
}

variable "private_subnet_az" {
    default = "ap-southeast-2b"
}

variable "DMZ_subnet_az" {
    default = "ap-southeast-2c"
}

