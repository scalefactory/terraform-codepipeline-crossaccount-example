module "pipeline" {
  source = "./pipeline-account"

  github             = var.github
  region             = var.region
  target_role_arn    = module.target.target_role_arn
  target_bucket_name = var.target_bucket_name
  target_kms_key_arn = module.target.kms_key_arn

  providers = {
    "aws" = "aws.pipeline"
  }
}

module "target" {
  source = "./target-account"

  artifact_bucket_arn   = module.pipeline.artifact_bucket_arn
  artifact_kms_key_arn  = module.pipeline.artifact_kms_key_arn
  bucket_name           = var.target_bucket_name
  codepipeline_role_arn = module.pipeline.codepipeline_role_arn

  providers = {
    "aws" = "aws.target"
  }
}

output "test" {
  value = module.pipeline.pipeline_arn
}
