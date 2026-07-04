output "aws_eks_cluster_name" {
  value = module.aws_eks.cluster_name
}

output "aws_eks_cluster_endpoint" {
  value = module.aws_eks.cluster_endpoint
}

output "aws_node_group_name" {
  value = module.aws_nodegroup.node_group_name
}

output "aws_vpc_id" {
  value = module.aws_vpc.vpc_id
}

output "azure_aks_cluster_name" {
  value = module.azure_aks.cluster_name
}

output "azure_aks_cluster_id" {
  value = module.azure_aks.cluster_id
}

output "azure_vnet_id" {
  value = module.azure_network.vnet_id
}