variable "accounts" {
  type = "map"
}

variable "github" {
  type = "map"
}

variable "region" {
  type = "string"
}

variable "terraform_role" {
  type = "string"
}

variable "target_bucket_name" {
  type = "string"
  default = "example-codepipeline-cross-account-target-bucket"
}
