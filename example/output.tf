output "route53_hosted_zones" {
  value       = module.route53_zone.route53_hosted_zones
  description = "Map of created Route53 hosted zones from the wrapper module"
}

output "route53_records" {
  value       = module.route53_zone.route53_records
  description = "Map of created Route53 records from the wrapper module"
}
