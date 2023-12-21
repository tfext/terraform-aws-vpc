# Create one or more NAT gateways and assign them to the private subnets
locals {
  nat_count = 0 // local.private_route_table_count
}

resource "aws_eip" "nat" {
  count = local.nat_count
  vpc   = true

  tags = merge(
    {
      Name = join("", [
        var.name,
        "-nat",
        var.multi_az_nat ? "-${module.aws_utils.availability_zone_suffixes[count.index]}" : ""
      ])
    },
    module.utils.default_tags
  )

  depends_on = [module.public_subnets, aws_internet_gateway.vpc]
}

resource "aws_nat_gateway" "vpc" {
  count         = local.nat_count
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(module.public_subnets.subnet_ids, count.index)

  tags = merge(
    {
      Name = join("", [
        var.name,
        var.multi_az_nat ? "-${module.aws_utils.availability_zone_suffixes[count.index]}" : ""
      ])
    },
    module.utils.default_tags
  )
}

resource "aws_route" "nat" {
  count                  = local.nat_count
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = module.utils.cidr_block_world
  nat_gateway_id         = element(aws_nat_gateway.vpc.*.id, count.index)
}
