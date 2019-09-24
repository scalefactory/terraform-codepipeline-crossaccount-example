resource "aws_iam_policy_attachment" "target" {
  name       = "target-role-attachment"
  roles      = [aws_iam_role.target.name]
  policy_arn = aws_iam_policy.target.arn
}
