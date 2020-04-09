resource aws_vpc vpc {
  cidr_block                       = var.cidr_block
  enable_dns_support               = var.with_dns_support
  enable_dns_hostnames             = var.with_dns_hostnames
  assign_generated_ipv6_cidr_block = var.with_ipv6_cidr_block
  tags                             = var.tags
}
