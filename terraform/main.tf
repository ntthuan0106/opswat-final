module "vpc_eks_name" {
  source = "./modules/eks"
  subnet_name = "thuan-test"
  node_group_name = "test"
  cluster_name = "thuan-eks"
  arn_cluster_role = var.arn_cluster_role
  vpc_eks_name = "eks-vpc"
  region = "us-east-1"
}