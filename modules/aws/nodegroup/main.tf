resource "aws_eks_node_group" "main" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-nodegroup"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  disk_size = 20
}