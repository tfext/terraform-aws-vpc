module "private_subnets" {
  source           = "github.com/dan-drew/terraform-aws-subnets"
  cidr_block       = cidrsubnet(var.cidr_block, var.subnet_group_cidr_bits, var.private_subnet_offset)
  subnet_cidr_bits = var.subnet_cidr_bits
  name             = "private"
  subnet_count     = var.subnet_count
  vpc_id           = aws_vpc.vpc.id
  route_table_ids  = aws_route_table.private.*.id
}

module "public_subnets" {
  source           = "github.com/dan-drew/terraform-aws-subnets"
  cidr_block       = cidrsubnet(var.cidr_block, var.subnet_group_cidr_bits, var.public_subnet_offset)
  name             = "public"
  subnet_type      = "public"
  subnet_count     = var.subnet_count
  subnet_cidr_bits = var.subnet_cidr_bits
  vpc_id           = aws_vpc.vpc.id
  route_table_ids  = aws_route_table.public.*.id
}

