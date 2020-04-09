# AWS VPC Terraform Module

TODO: Description

## Variables

| Name                           | Description
|--------------------------------|---
| role_arn                       | The role to assume to create resources
| region                         | The AWS region to create resources in
| name                           | The name of the VPC
| domain                         | The domain of the VPC
| tags                           | A map of tags to apply to the created resources
| cidr_block                     | The CIDR block to assign to the VPC
| with_ipv6_cidr_block           | Assign IPv6 CIDR block or not, default: false
| with_dns_support               | Enable DNS support in the VPC, default: true
| with_dns_hostnames             | Enable DNS hostnames in the VPC, default: true
| with_internet_gateway          | Create an Internet Gateway for external access, default: false
| with_private_r53_zone          | Create a private Route53 Zone for the VPC, default: false
| with_vpc_flow_log              | Create a VPC Flow Log for the VPC, default: true
| vpc_flow_log_traffic_type      | The type of traffic to capture, default: ALL
| vpc_flow_log_retention_in_days | The number of days to retain logs in the Cloudwatch Log Group, default: 7

## Outputs

| Name                | Description
|---------------------|---|
| vpc_id              | The ID of the VPC
| internet_gateway_id | The ID of the Internet Gateway if created
