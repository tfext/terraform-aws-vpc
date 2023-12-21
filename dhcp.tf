# If a custom domain was specified then create options with the provided value
# Otherwise just pull in the default and tag it

data "aws_region" "current" {
}

locals {
  default_domain_name = data.aws_region.current.endpoint
}

resource "aws_vpc_dhcp_options" "vpc" {
  domain_name         = join(" ", compact(concat(var.dhcp_domain_names, [local.default_domain_name])))
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = { Name = var.name }
}

resource "aws_vpc_dhcp_options_association" "vpc" {
  dhcp_options_id = aws_vpc_dhcp_options.vpc.id
  vpc_id          = aws_vpc.vpc.id
}

