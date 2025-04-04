variable "eks_cidr_block" {
  type = string
  description = "EkS CIDR block"
  default = "172.16.0.0/16"
}

variable "vpc_eks_name" {
  type = string
  description = "VPC name"
}

variable "arn_cluster_role" {
  type = string
  description = "Cluster role"
}
variable "k8s_version" {
  type = string
  description = "K8s version"
  default = "1.31"
}
variable "cluster_name" {
  type = string
  description = "EKS cluster name"
}
variable "node_group_name"{
    type = string
    description = "EKS node group name"
}
variable "amount_of_subnet"{
    type = number
    default = 2
    description = "Number subnets in cluster"
    validation {
      condition = var.amount_of_subnet >=2
      error_message = "Specify at list 2 subnet"
    }
}
variable "region"{
    type = string
    description = "EKS located region"
}
variable "subnet_name" {
  type = string
  description = "Subnet name"
}
variable "enabled_ELB" {
  type = bool
  default = true
  description = "Enable Elastic Load Balancing"
}

