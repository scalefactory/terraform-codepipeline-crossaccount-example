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
      type        = "AWS"
      identifiers = [aws_iam_role.target.arn]
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
      type        = "AWS"
      identifiers = [aws_iam_role.target.arn]
    }

    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}

data "aws_iam_policy_document" "target" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.target.arn,
      "${aws_s3_bucket.target.arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]

    resources = [
      "${aws_kms_key.target-key.arn}"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      var.artifact_bucket_arn,
      "${var.artifact_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]

    resources = [
      var.artifact_kms_key_arn
    ]
  }
}
