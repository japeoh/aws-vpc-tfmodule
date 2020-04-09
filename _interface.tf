variable role_arn {}

variable region {}

variable name {}

variable domain {}

variable tags {
  type    = map(string)
  default = {}
}

variable cidr_block {}

variable with_ipv6_cidr_block {
  type    = bool
  default = false
}

variable with_dns_support {
  type    = bool
  default = true
}

variable with_dns_hostnames {
  type    = bool
  default = true
}

variable with_internet_gateway {
  type    = bool
  default = false
}

variable with_private_r53_zone {
  type    = bool
  default = false
}

variable with_vpc_flow_log {
  type    = bool
  default = true
}

variable vpc_flow_log_traffic_type {
  default = "ALL"
}

variable vpc_flow_log_retention_in_days {
  type    = number
  default = 7
}

data aws_caller_identity current {}

output vpc_id {
  value = aws_vpc.vpc.id
}

output internet_gateway_id {
  value = local.internet_gateway_id
}

provider aws {
  version = "~> 2.53"
  region  = var.region

  assume_role {
    role_arn = var.role_arn
  }
}
