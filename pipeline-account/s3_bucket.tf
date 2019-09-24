resource "aws_s3_bucket" "artifact-bucket" {
  bucket = var.artifact_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowRoleInTargetAccount",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.target_role_arn}"
      },
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.artifact_bucket_name}/*"
    }
  ]
}
POLICY
}
