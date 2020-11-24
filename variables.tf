variable "name" {
  description = "Name of the CosmosDB Account."
}

variable "resource_group_name" {
  description = "Name of resource group to deploy resources in."
}

variable "enable_automatic_failover" {
  description = "Set failover required or not."
  type = bool
}

variable "failover_location" {
  description = "The Azure Region in which to create failover resource."
}


variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
