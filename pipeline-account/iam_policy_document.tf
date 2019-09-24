data "aws_iam_policy_document" "kms-usage" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    actions = [
      "kms:*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = ["*"]
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    principals {
      type = "AWS"
      identifiers = [
        # local.pipeline_arn
        "*"
      ]
    }

    resources = ["*"]
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]

    principals {
      type = "AWS"
      identifiers = [
        # local.pipeline_arn
        "*"
      ]
    }

    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

data "aws_iam_policy_document" "codepipeline" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      var.target_role_arn,
    ]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.artifact-bucket.arn,
      "${aws_s3_bucket.artifact-bucket.arn}/*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]

    resources = [
      aws_kms_key.artifacts.arn,
    ]
  }
}
