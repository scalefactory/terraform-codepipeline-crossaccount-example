resource "aws_kms_key" "target-key" {
  policy = data.aws_iam_policy_document.kms-usage.json
}
