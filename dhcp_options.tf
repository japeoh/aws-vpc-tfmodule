resource aws_vpc_dhcp_options dhcp_options {
  domain_name         = local.dhcp_options_domain
  domain_name_servers = ["AmazonProvidedDNS"]
  tags                = var.tags
}

resource aws_vpc_dhcp_options_association dns_resolver {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}
