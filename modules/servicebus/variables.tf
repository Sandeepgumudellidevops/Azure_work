variable "name" {
  type        = string
  description = "The name of the namespace."
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
