output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = var.public_subnet_cidrs[0].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}


output "private_route_table_id" {
  value = aws_route_table.private.id
}


output "database_route_table_id" {
  value = aws_route_table.database.id
}

