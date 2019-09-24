resource "aws_s3_bucket" "artifact-bucket" {
  bucket = var.artifact_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}
