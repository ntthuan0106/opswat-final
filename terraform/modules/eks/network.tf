resource "aws_vpc" "eks_vpc" {
  cidr_block = var.eks_cidr_block

  tags = {
    Name = var.vpc_eks_name
  }
}
# EKS Public network
resource "aws_subnet" "subnet_pub" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.eks_cidr_block, 4, count.index)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
  count             = var.amount_of_pub_subnet
  tags = {
    Name = "${lower(var.cluster_name)}-subnet-pub-${count.index}"
  }
}
resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "${lower(var.cluster_name)}-rt-pub"
  }
}
resource "aws_route_table_association" "attach_pub_rt" {
  count = var.amount_of_pub_subnet
  route_table_id = aws_route_table.route_table_pub.id
  subnet_id = aws_subnet.subnet_pub[count.index].id
  depends_on = [ aws_subnet.subnet_pub ]
}

# EKS Private network
resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.eks_cidr_block, 4, count.index + var.amount_of_pub_subnet)
  availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
  count             = var.amount_of_private_subnet
  tags = {
    Name = "${lower(var.cluster_name)}-subnet-private-${count.index}"
  }
}
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "${lower(var.cluster_name)}-rt-private"
  }
}
resource "aws_route_table_association" "attach_private_rt" {
  count = var.amount_of_private_subnet
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.subnet_private[count.index].id
  depends_on = [ aws_subnet.subnet_private ]
}