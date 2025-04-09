variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}
variable "arn_cluster_role" {
  type = string
  description = "Cluster role"
}
variable "arn_node_role" {
  type = string
  description = "Node role"
}
variable "k8s_version" {
  type = string
  description = "K8s version"
  default = "1.31"
}
variable "node_group_name"{
    type = string
    description = "EKS node group name"
}
variable "desired_size" {
  type = number
  default = 1
  description = "Desire EKS node"
}
variable "min_size" {
  type = number
  default = 1
  description = "Min EKS node"
  validation {
    condition = var.min_size > 0
    error_message = "Min size >= 1"
  }
}
variable "max_size" {
  type = number
  default = 2
  description = "Max EKS nodes"
  validation {
    condition = var.max_size >= 2
    error_message = "Max size >= 2"
  }
}
variable "eks_addon_list" {
  type = list(object({
    name =string
    version = optional(string)
  }))
}
variable "eks_instance_types" {
  type = list(string)
  description = "EKS instance types"
  default = ["t3.medium"]
}
variable "node_instance_type" {
  type = string
  description = "Node instance type"
  default = "t3.medium"
}
variable "ami_id_name" {
  type = string
  description = "AMI id"
  /// Default AMI detail: Canonical, Ubuntu EKS Node OS (1.31), 22.04 LTS, amd64 jammy image
  default = "ami-0763f2bf5f221902d"
}
variable "prefix_name" {
  type = string
  description = "Instance template prefix name"
}

