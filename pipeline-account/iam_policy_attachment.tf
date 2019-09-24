resource "aws_iam_policy_attachment" "codepipeline" {
  name       = "codepipeline-role-attachment"
  roles      = [aws_iam_role.codepipeline.name]
  policy_arn = aws_iam_policy.codepipeline.arn
}
