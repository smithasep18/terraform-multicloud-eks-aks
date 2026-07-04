module "aws_vpc" {
  source = "./modules/aws/vpc"

  vpc_cidr        = var.aws_vpc_cidr
  public_subnets  = var.aws_public_subnets
  private_subnets = var.aws_private_subnets
  azs             = var.aws_azs
  cluster_name    = var.aws_cluster_name
}

module "aws_iam" {
  source = "./modules/aws/iam"

  cluster_name = var.aws_cluster_name
}

module "aws_eks" {
  source = "./modules/aws/eks"

  cluster_name     = var.aws_cluster_name
  cluster_role_arn = module.aws_iam.cluster_role_arn
  subnet_ids       = module.aws_vpc.private_subnet_ids

  depends_on = [module.aws_iam]
}

module "aws_nodegroup" {
  source = "./modules/aws/nodegroup"

  cluster_name        = module.aws_eks.cluster_name
  node_group_role_arn = module.aws_iam.node_group_role_arn
  subnet_ids          = module.aws_vpc.private_subnet_ids

  depends_on = [module.aws_eks]
}

module "azure_rg" {
  source = "./modules/azure/resource-group"

  resource_group_name = var.azure_resource_group_name
  location            = var.azure_location
}

module "azure_network" {
  source = "./modules/azure/network"

  resource_group_name     = module.azure_rg.resource_group_name
  location                = module.azure_rg.location
  vnet_name               = "azure-aks-vnet"
  vnet_address_space      = [var.azure_vnet_cidr]
  subnet_name             = "aks-subnet"
  subnet_address_prefixes = [var.azure_subnet_cidr]
  gateway_subnet_address_prefixes = [var.azure_gateway_subnet_cidr]

  depends_on = [module.azure_rg]
}

module "azure_aks" {
  source = "./modules/azure/aks"

  cluster_name        = var.azure_cluster_name
  location            = module.azure_rg.location
  resource_group_name = module.azure_rg.resource_group_name
  subnet_id           = module.azure_network.subnet_id
  service_cidr   = var.azure_service_cidr
  dns_service_ip = var.azure_dns_service_ip 

  depends_on = [module.azure_network]
}
