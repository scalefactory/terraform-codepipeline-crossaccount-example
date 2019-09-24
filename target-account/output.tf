output "target_role_arn" {
  value = aws_iam_role.target.arn
}

output "kms_key_arn" {
  value = aws_kms_key.target-key.arn
}
