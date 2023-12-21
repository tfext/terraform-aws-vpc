module "aws_utils" {
  source = "github.com/dan-drew/terraform-aws-base"
}

locals {
  named_tags = { Name = var.name }
}
