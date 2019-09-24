resource "aws_kms_key" "artifacts" {
  policy = data.aws_iam_policy_document.kms-usage.json
}
