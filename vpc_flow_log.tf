resource aws_flow_log vpc_flow_log {
  count = local.vpc_flow_log_count

  vpc_id          = aws_vpc.vpc.id
  log_destination = aws_cloudwatch_log_group.vpc_flow_log.*.arn[0]
  traffic_type    = var.vpc_flow_log_traffic_type
  iam_role_arn    = aws_iam_role.vpc_flow_log.*.arn[0]

  tags = merge(
    var.tags,
    map("Name", local.vpc_flow_log_name),
  )
}

resource aws_cloudwatch_log_group vpc_flow_log {
  count = local.vpc_flow_log_count

  name              = local.vpc_flow_log_name
  retention_in_days = var.vpc_flow_log_retention_in_days
  kms_key_id        = aws_kms_key.vpc_flow_log.*.arn[0]

  tags = merge(
    var.tags,
    map("Name", local.vpc_flow_log_name),
  )
}

resource aws_iam_role vpc_flow_log {
  count = local.vpc_flow_log_count

  name               = local.vpc_flow_log_name
  path               = "/network/"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_log_assume_role_policy.json

  tags = merge(
    var.tags,
    map("Name", local.vpc_flow_log_name),
  )
}

data aws_iam_policy_document vpc_flow_log_assume_role_policy {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = ["vpc-flow-logs.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource aws_iam_role_policy vpc_flow_log_access {
  count = local.vpc_flow_log_count

  name   = "cloudwatch-log-group-access"
  role   = aws_iam_role.vpc_flow_log.*.id[0]
  policy = data.aws_iam_policy_document.vpc_flow_log_access_policy.json
}

data aws_iam_policy_document vpc_flow_log_access_policy {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = [
      "*",
    ]
  }
}

resource aws_kms_key vpc_flow_log {
  count = local.vpc_flow_log_count

  description             = "Key for ${var.domain} VPC Flow Logs"
  policy                  = data.aws_iam_policy_document.vpc_flow_log_key_policy.json
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(
    var.tags,
    map("Name", local.vpc_flow_log_name),
  )
}

resource aws_kms_alias vpc_flow_log {
  count = local.vpc_flow_log_count

  name          = "alias/${replace(local.vpc_flow_log_name, ".", "-")}"
  target_key_id = aws_kms_key.vpc_flow_log.*.key_id[count.index]
}

data aws_iam_policy_document vpc_flow_log_key_policy {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
      type = "AWS"
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"
    principals {
      identifiers = ["logs.${var.region}.amazonaws.com"]

      type = "Service"
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]
    resources = [
      "*",
    ]
  }
}
