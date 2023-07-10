variable "region" {
  description = "define the AWS region to be used"
  type        = string
  default = "us-west-2"
 
  validation {
  condition = can(regex("^([a-z0-9-'])+$", var.region))
        error_message = "Please use a valid AWS region (eg. us-west-1)."
  }
}
 
variable "cidr_block" {
  description = "define the cidr_block for vpc"
  type        = string
  default     = "10.0.0.0/18"
 
  validation {
  condition = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.cidr_block))
        error_message = "Must be in valid vpc cidr block format ranging from '16 -28'."
  }
}
 
variable "tags" {
  description = "set the name for vpc"
  type        = string
  default     = "WGinfrastructure"
 
  validation {
  condition = can(regex("^([a-zA-Z0-9-'])+$", var.tags))
        error_message = "Please try to stick to a good naming convention no special charcters hyphens are ok."
  }
}
