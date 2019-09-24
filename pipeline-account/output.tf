output "artifact_bucket_arn" {
  value = aws_s3_bucket.artifact-bucket.arn
}

output "artifact_kms_key_arn" {
  value = aws_kms_key.artifacts.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline.arn
}

output "pipeline_arn" {
  value = local.pipeline_arn
}
