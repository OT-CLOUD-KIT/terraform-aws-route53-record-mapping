variable "route53_zone" {
  type = map(object({
    comment           = optional(string)
    delegation_set_id = optional(string)
    tags              = optional(map(string))
    force_destroy     = optional(bool, false)
    private_zone = optional(map(object({
      vpc_id     = string
      vpc_region = string
    })))
  }))
  default     = null
  description = "Route53 hosted zones detail"
}

variable "route53_record" {
  type = map(object({
    record_name                      = optional(string)
    type                             = string
    ttl                              = number
    hosted_zone_name                 = optional(string)
    zone_id                          = optional(string)
    records                          = optional(list(string))
    set_identifier                   = optional(string)
    health_check_id                  = optional(string)
    multivalue_answer_routing_policy = optional(bool)
    allow_overwrite                  = optional(bool)
    alias = optional(list(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    })))
    cidr_routing_policy = optional(list(object({
      collection_id = string
      location_name = string
    })))
    failover_routing_policy = optional(list(object({
      type = string
    })))
    geolocation_routing_policy = optional(list(object({
      continent   = string
      country     = string
      subdivision = string
    })))
    latency_routing_policy = optional(list(object({
      region = string
    })))
    weighted_routing_policy = optional(list(object({
      weight = number
    })))
  }))
  default     = null
  description = "Route53 records for a specific hosted zone"

}