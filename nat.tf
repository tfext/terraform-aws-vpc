# Create one or more NAT gateways and assign them to the private subnets
locals {
  nat_count = 0 // local.private_route_table_count
}

resource "aws_eip" "nat" {
  count = local.nat_count
  domain = "vpc"

  tags = {
      Name = join("", [
        var.name,
        "-nat",
        var.multi_az_nat ? "-${module.aws_utils.availability_zone_suffixes[count.index]}" : ""
      ])
    }

  depends_on = [module.public_subnets, aws_internet_gateway.vpc]
}

resource "aws_nat_gateway" "vpc" {
  count         = local.nat_count
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(module.public_subnets.subnet_ids, count.index)

  tags = {
      Name = join("", [
        var.name,
        var.multi_az_nat ? "-${module.aws_utils.availability_zone_suffixes[count.index]}" : ""
      ])
    }
}

resource "aws_route" "nat" {
  count                  = local.nat_count
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = module.aws_utils.cidr_block_world
  nat_gateway_id         = element(aws_nat_gateway.vpc.*.id, count.index)
}
