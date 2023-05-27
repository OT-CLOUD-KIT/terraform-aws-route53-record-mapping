output "route53_hosted_zones" {
  value = aws_route53_zone.www
  description = "Route53 hosted zones"
}

output "route53_records" {
  value = aws_route53_record.www
  description = "Route53 hosted zone's records"
}