resource "aws_route53_zone" "www" {
  for_each          = var.route53_zone != null ? var.route53_zone : {}
  name              = each.key
  tags              = each.value.tags
  comment           = each.value.comment
  force_destroy     = each.value.force_destroy
  delegation_set_id = each.value.private_zone == null ? each.value.delegation_set_id : null
  dynamic "vpc" {
    for_each = each.value.private_zone != null ? each.value.private_zone : {}
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }
}

resource "aws_route53_record" "www" {
  for_each        = var.route53_record != null ? var.route53_record : {}
  zone_id         = each.value.zone_id == null ? aws_route53_zone.www[each.value.hosted_zone_name].zone_id : each.value.zone_id
  name            = each.value.record_name != null ? each.value.record_name : each.key
  type            = each.value.type
  ttl             = each.value.ttl
  records         = each.value.records
  set_identifier  = each.value.failover_routing_policy == null && each.value.geolocation_routing_policy == null && each.value.latency_routing_policy == null && each.value.weighted_routing_policy == null && each.value.cidr_routing_policy == null ? null : each.value.set_identifier
  health_check_id = each.value.health_check_id

  dynamic "alias" {
    for_each = each.value.ttl == null && each.value.records == null && each.value.alias != null ? each.value.alias : []
    content {
      name                   = alias.value.name
      zone_id                = alias.value.zone_id
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }

  dynamic "cidr_routing_policy" {
    for_each = each.value.failover_routing_policy == null && each.value.geolocation_routing_policy == null && each.value.latency_routing_policy == null && each.value.weighted_routing_policy == null && each.value.cidr_routing_policy != null ? each.value.cidr_routing_policy : []
    content {
      collection_id = cidr_routing_policy.value.collection_id
      location_name = cidr_routing_policy.value.location_name
    }
  }

  dynamic "failover_routing_policy" {
    for_each = each.value.cidr_routing_policy == null && each.value.geolocation_routing_policy == null && each.value.latency_routing_policy == null && each.value.weighted_routing_policy == null && each.value.failover_routing_policy != null ? each.value.failover_routing_policy : []
    content {
      type = failover_routing_policy.value.type
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = each.value.cidr_routing_policy == null && each.value.failover_routing_policy == null && each.value.latency_routing_policy == null && each.value.weighted_routing_policy == null && each.value.geolocation_routing_policy != null ? each.value.geolocation_routing_policy : []
    content {
      continent   = geolocation_routing_policy.value.continent
      country     = geolocation_routing_policy.value.country
      subdivision = geolocation_routing_policy.value.subdivision
    }
  }

  dynamic "latency_routing_policy" {
    for_each = each.value.cidr_routing_policy == null && each.value.failover_routing_policy == null && each.value.geolocation_routing_policy == null && each.value.weighted_routing_policy == null && each.value.latency_routing_policy != null ? each.value.latency_routing_policy : []
    content {
      region = latency_routing_policy.value.region
    }
  }

  dynamic "weighted_routing_policy" {
    for_each = each.value.cidr_routing_policy == null && each.value.failover_routing_policy == null && each.value.latency_routing_policy == null && each.value.geolocation_routing_policy == null && each.value.weighted_routing_policy != null ? each.value.weighted_routing_policy : []
    content {
      weight = weighted_routing_policy.value.weight
    }
  }

  allow_overwrite = each.value.allow_overwrite
}