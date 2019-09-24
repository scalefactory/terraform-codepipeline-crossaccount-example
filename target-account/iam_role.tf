resource "aws_iam_role" "target" {
  name = "CodePipelineAssumedRoleInTargetAccount"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.codepipeline_role_arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
}
