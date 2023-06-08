module "route53_zone" {
  source         = "./route53"
  route53_zone   = var.route53_zone
  route53_record = var.route53_record
}