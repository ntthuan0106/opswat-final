output "list_subnet_id" {
  value = aws_subnet.subnet-res[*].id
}