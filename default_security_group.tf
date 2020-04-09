resource aws_default_security_group default {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    var.tags,
    map("Name", local.default_name, ),
  )
}
