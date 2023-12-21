# 1. Pulls the default table into management and tags it
# 2. Creates a single table for public subnets
# 3. In multi-az mode, creates a table per private subnet. Each will get it's own NAT.
#    Otherwise creates a single table that will share a NAT.

locals {
  private_route_table_count = var.multi_az_nat ? var.subnet_count : 1
}

resource "aws_default_route_table" "vpc" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = merge(
    { Name = "${var.name}-default" },
    module.utils.default_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.name}-public" },
    module.utils.default_tags
  )
}

resource "aws_route_table" "private" {
  count  = local.private_route_table_count
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      Name = join("", [
        var.name,
        "-private",
        var.multi_az_nat ? "-${module.aws_utils.availability_zone_suffixes[count.index]}" : ""
      ])
    },
    module.utils.default_tags
  )
}
