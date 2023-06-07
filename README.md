# Route53 
[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This module helps users in setup:
- Hosted zones
- Records

## Prerequisites
- AWS access with permission for Route53
- Terraform
- AWS CLI
## Providers
AWS

## Note
- This module has to resources route53_zone and route53_record users can use either together or individual resources.
- If user has more than one record with same name than you can use record_name var: under route53_record.

## Input
| Name | Description | Type | Default | Required |
|-------|----------|------|-----|-----|
| route53_zone | User input for hosted zone  | map(object) | null | no |
| route53_record | About record inside hosted zone | map(object) | null | no |

## Output
| Name | Description |
|------|-------------|
| route53_hosted_zones | Route53 hosted zones |
| route53_records | Route53 hosted zone's records |

## Usage
```hcl
module "route53_zone" {
  source         = "./modules"
  route53_zone   = var.route53_zone
  route53_record = var.route53_record
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
        Type      = "Public"
      }
    }
  }
}

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

```
## Contributor
[Ashutosh Yadav](https://github.com/ashutoshyadav66)
