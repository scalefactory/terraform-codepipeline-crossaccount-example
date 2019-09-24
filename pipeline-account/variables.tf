variable "github" {
  type = "map"
}

variable "region" {
  type = "string"
}

variable "target_role_arn" {
  type = "string"
}

variable "target_bucket_name" {
  type = "string"
}

variable "target_kms_key_arn" {
  type = "string"
}

variable "artifact_bucket_name" {
  type    = "string"
  default = "example-codepipeline-cross-account-pipeline-artifact-bucket"
}

variable "pipeline_name" {
  type    = "string"
  default = "ExamplePipeline"
}

locals {
  pipeline_arn = "arn:aws:codepipeline:${replace(var.region, "-", "")}:${data.aws_caller_identity.current.account_id}:${var.pipeline_name}"
}
