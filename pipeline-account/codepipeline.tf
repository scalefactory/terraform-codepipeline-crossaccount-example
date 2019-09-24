resource "aws_codepipeline" "pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifact-bucket.bucket
    type     = "S3"

    encryption_key {
      id   = aws_kms_key.artifacts.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      name     = "Source"
      owner    = "ThirdParty"
      provider = "GitHub"
      version  = "1"

      output_artifacts = ["SourceArtifact"]

      configuration = {
        Owner  = var.github["owner"]
        Repo   = var.github["repo"]
        Branch = var.github["branch"]
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      version         = "1"
      run_order       = "1"
      role_arn        = var.target_role_arn
      input_artifacts = ["SourceArtifact"]

      configuration = {
        ObjectKey           = "DeployedArtifacts"
        Extract             = "false"
        BucketName          = var.target_bucket_name
        KMSEncryptionKeyARN = var.target_kms_key_arn
      }
    }
  }
}
