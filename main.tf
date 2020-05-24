resource "aws_route53_record" "www" {
  count = length(var.dns_names)
  name  = element(var.dns_names, count.index)

  zone_id = var.zone_id
  type    = var.rout53_record_type
  ttl     = var.ttl
  records = var.records_name
}
