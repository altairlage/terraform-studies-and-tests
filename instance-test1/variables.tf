variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "WGExampleInstance"
 
    validation {
    condition     = can(regex("^([a-zA-Z0-9])+$", var.instance_name))
        error_message = "Must be a valid instance name, can contain letters and numbers."
    }
 
}
 
output "instance_name" {
    value = var.instance_name
}
