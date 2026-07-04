variable "resource_group_name" {}

variable "location" {}

variable "vnet_name" {}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet_name" {}

variable "subnet_address_prefixes" {
  type = list(string)
}