variable "route53_record" {
  type = map(object({
    hosted_zone_name = string
    type             = string
    ttl              = number
    records          = optional(list(string))
  }))
  default = {
    "example-record-name-1" = {
      hosted_zone_name = "example.com"
      type             = "CNAME"
      ttl              = 30
      records          = ["another-domain-aws-service"]
    }
    "example-record-name-2" = {
      hosted_zone_name = "xyz.com"
      type             = "A"
      ttl              = 30
      records          = ["x.x.x.x"]
    }
  }
}

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
  default = {
    "example.com" = {
      comment = "example private hosted zone"
      tags = {
        ManagedBy = "Terraform"
        Name      = "Example"
        Type      = "Private"
      }
      private_zone = {
        "pw-production-vpc" = {
          vpc_id     = "vpc-1234567890"
          vpc_region = "ap-south-1"
        }
      }
    }
    "xyz.com" = {
      comment = "xyz public hosted zone"
      tags = {
        ManagedBy = "Terraform"
        Name      = "Example"
        Type      = "Private"
      }
    }
  }
}
