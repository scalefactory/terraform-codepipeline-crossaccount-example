resource "aws_iam_policy" "target" {
  policy = data.aws_iam_policy_document.target.json
}
