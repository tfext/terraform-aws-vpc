output "id" {
  value = aws_vpc.vpc.id
}

output "name" {
  value = var.name
}

output "subnet_count" {
  value = var.subnet_count
}

output "public_route_table_count" {
  value = 1
}

output "private_route_table_count" {
  value = local.private_route_table_count
}

output "cidr_block" {
  value = var.cidr_block
}

output "public_route_table_ids" {
  value = aws_route_table.public.*.id
}

output "private_route_table_ids" {
  value = aws_route_table.private.*.id
}

output "public_subnet_ids" {
  value = module.public_subnets.subnet_ids
}

output "private_subnet_ids" {
  value = module.private_subnets.subnet_ids
}

output "public_ips" {
  value = formatlist("%s/32", aws_eip.nat.*.public_ip)
}
