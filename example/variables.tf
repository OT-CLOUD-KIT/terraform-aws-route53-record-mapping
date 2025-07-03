

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
  default     = {}
  description = "Route53 hosted zones detail"
}

variable "route53_record" {
  type = map(object({
    hosted_zone_name                  = string
    type                              = string
    ttl                               = optional(number)
    records                           = optional(list(string))
    zone_id                           = optional(string)
    set_identifier                    = optional(string)
    health_check_id                   = optional(string)
   multivalue_answer_routing_policy = optional(bool)
    allow_overwrite                   = optional(bool, false)

    alias = optional(list(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    })), [])

    cidr_routing_policy = optional(list(object({
      collection_id = string
      location_name = string
    })), [])

    failover_routing_policy = optional(list(object({
      type = string
    })), [])

    geolocation_routing_policy = optional(list(object({
      continent   = optional(string)
      country     = optional(string)
      subdivision = optional(string)
    })), [])

    latency_routing_policy = optional(list(object({
      region = string
    })), [])

    weighted_routing_policy = optional(list(object({
      weight = number
    })), [])
  }))
  default     = {}
  description = "Route53 records for a specific hosted zone"
}
