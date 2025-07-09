terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket"
    key    = "ot/module/route53/terraform.tfstate"
    region = "us-east-1"

  }
}