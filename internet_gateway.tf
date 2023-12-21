# Create a gateway and assign it to the public route table

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.named_tags
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = module.utils.cidr_block_world
  gateway_id             = aws_internet_gateway.vpc.id
}

