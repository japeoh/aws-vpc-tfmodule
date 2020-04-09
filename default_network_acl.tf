resource aws_default_network_acl default {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  tags = merge(
    var.tags,
    map("Name", local.default_name, ),
  )
}
