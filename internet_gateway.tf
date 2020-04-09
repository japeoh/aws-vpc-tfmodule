resource aws_internet_gateway internet_gateway {
  count = local.internet_gateway_count

  vpc_id = aws_vpc.vpc.id

  tags = var.tags
}
