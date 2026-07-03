variable "cluster_name" {}

variable "node_group_role_arn" {}

variable "subnet_ids" {
  type = list(string)
}