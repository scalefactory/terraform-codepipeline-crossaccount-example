provider "aws" {
  alias  = "target"
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts["target"]}:role/${var.terraform_role}"
  }
}

provider "aws" {
  alias  = "pipeline"
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::${var.accounts["pipeline"]}:role/${var.terraform_role}"
  }
}
