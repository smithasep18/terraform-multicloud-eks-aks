variable "aws_region" {
  default = "us-east-1"
}

variable "aws_cluster_name" {
  default = "aws-eks-cluster"
}

variable "azure_cluster_name" {
  default = "azure-aks-cluster"
}

variable "aws_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "aws_public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aws_private_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "aws_azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "azure_location" {
  default = "East US"
}

variable "azure_resource_group_name" {
  default = "rg-multicloud-k8s"
}

variable "azure_vnet_cidr" {
  default = "10.1.0.0/16"
}

variable "azure_subnet_cidr" {
  default = "10.1.1.0/24"
}

variable "azure_subscription_id" {
  type = string
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_client_id" {
  type = string
}

variable "azure_client_secret" {
  type      = string
  sensitive = true
}