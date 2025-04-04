resource "aws_vpc" "test-vpc" {
  cidr_block = var.eks_cidr_block

  tags = {
    Name = var.vpc_eks_name
  }
}

resource "aws_subnet" "subnet-res" {
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = cidrsubnet(var.eks_cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
  count = var.amount_of_subnet
  tags = {
    Name = "${lower(var.subnet_name)}-${count.index}"
  }
}
resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = var.arn_cluster_role
  vpc_config {
    subnet_ids = aws_subnet.subnet-res[*].id
  }
}

resource "aws_eks_node_group" "EKS_node_group" {
  cluster_name = aws_eks_cluster.cluster.name
  subnet_ids = aws_subnet.subnet-res[*].id
  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 3
  }
  node_role_arn = var.arn_cluster_role
}


