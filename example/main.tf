module "route53_zone" {
  source         = "git@github.com:OT-CLOUD-KIT/terraform-aws-route53-record-mapping.git?ref=Feature"
  route53_zone   = var.route53_zone
  route53_record = var.route53_record
}