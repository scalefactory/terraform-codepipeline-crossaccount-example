resource "aws_s3_bucket" "target" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}
