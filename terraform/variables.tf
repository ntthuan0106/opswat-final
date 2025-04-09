variable "access_key" {
    type = string
}
variable "secret_key" {
    type = string
}
variable "arn_cluster_role" {
  type = string
}
variable "arn_node_role" {
  type = string
  description = "Node role"
}