output "artifact_bucket_arn" {
  value = aws_s3_bucket.artifact-bucket.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline.arn
}

output "kms_policy" {
  value = data.aws_iam_policy_document.kms-usage.json
}

output "pipeline_arn" {
  value = local.pipeline_arn
}
