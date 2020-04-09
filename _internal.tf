locals {
  default_name           = format("%s.%s", "default", var.domain)
  dhcp_options_domain    = var.with_private_r53_zone ? var.domain : format("%s.%s", var.region, "compute.internal")
  internet_gateway_count = var.with_internet_gateway ? 1 : 0
  internet_gateway_id    = var.with_internet_gateway ? aws_internet_gateway.internet_gateway.*.id[0] : ""
  vpc_flow_log_count     = var.with_vpc_flow_log ? 1 : 0
  vpc_flow_log_name      = format("vpc-flow-log.%s", var.name)
}
