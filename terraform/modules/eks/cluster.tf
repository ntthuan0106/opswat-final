resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = var.arn_cluster_role
  vpc_config {
    subnet_ids = concat(
      aws_subnet.subnet_pub[*].id,
      aws_subnet.subnet_private[*].id
      )
  }
  bootstrap_self_managed_addons = true
}

resource "aws_eks_node_group" "EKS_node_group" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "${var.cluster_name}-nodegroup"
  subnet_ids = concat(
    aws_subnet.subnet_pub[*].id,
    aws_subnet.subnet_private[*].id
  )
  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
  release_version = var.k8s_version
  instance_types = var.eks_instance_types
  node_role_arn  = var.arn_node_role
}
resource "aws_launch_template" "eks" {
  name_prefix   = var.prefix_name
  image_id      = var.ami_id_name
  instance_type = var.node_instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "EKS-Node"
    }
  }
}

resource "aws_eks_addon" "eks_addon" {
  for_each = { for addon in var.eks_addon_list : addon.name => addon }

  cluster_name  = aws_eks_cluster.cluster.name
  addon_name    = each.value.name
  addon_version = each.value.version
  depends_on = [ aws_eks_node_group.EKS_node_group ]
}

