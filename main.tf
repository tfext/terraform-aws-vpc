module "aws_utils" {
  source = "github.com/tfext/terraform-aws-base"
}

locals {
  named_tags = { Name = var.name }
}
