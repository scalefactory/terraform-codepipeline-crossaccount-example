resource "aws_iam_policy" "codepipeline" {
  policy = data.aws_iam_policy_document.codepipeline.json
}
