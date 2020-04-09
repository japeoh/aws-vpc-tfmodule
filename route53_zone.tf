resource aws_route53_zone internal {
  count = var.with_private_r53_zone ? 1 : 0

  name          = var.domain
  comment       = format("Internal zone for %s vpc", var.name)
  force_destroy = true

  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  tags = var.tags
}
