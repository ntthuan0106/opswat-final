module "vpc_eks" {
  source           = "./modules/eks"
  
  cluster_name     = "thuan-eks"
  vpc_eks_name     = "eks-vpc"

  
  arn_cluster_role = var.arn_cluster_role
  arn_node_role = var.arn_cluster_role

  node_group_name  = "test"
  
  region           = "us-east-1"
  eks_addon_list = [
    { name = "vpc-cni" },
    { name = "coredns" },
    { name = "kube-proxy" },
    { name = "metrics-server" },
  ]
  prefix_name= "thuan-eks-node-template"
}



