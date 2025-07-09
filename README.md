# Terraform AWS Route 53

A Terraform module to manage **Route 53 Hosted Zones** (public and private) and **DNS Records** with full flexibility and variable-driven configurations.

---

## Architecture


![Screenshot from 2025-07-03 09-14-07](https://github.com/user-attachments/assets/978f9883-1093-4bf6-bff2-5c76093f8c4c)

> **Note:**  
> This module supports creation of public and private hosted zones, with optional VPC attachment for private zones and dynamic record creation.

---
## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\module) | >= 1.12.1|

---



## Usage
```hcl
module "route53_zone" {
  source         = "OT-CLOUD-KIT/terraform-aws-route53-record-mapping"
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

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

___

## Inputs


| Attribute | Description | Type | Required |
|-----------|-------------|------|----------|
| <a name="input_route53_zone.key"></a> `key` | Domain name of the hosted zone (e.g., `xyz.com`) | `string` | yes |
| <a name="input_route53_zone.comment"></a> `comment` | Optional comment about the zone | `string` | No |
| <a name="input_route53_zone.tags"></a> `tags` | Key-value tags to assign to the hosted zone | `map(string)` | No |
| <a name="input_route53_zone.force_destroy"></a> `force_destroy` | Whether to destroy the zone even if it contains records | `bool` | No (default: `false`) |
| <a name="input_route53_zone.private_zone"></a> `private_zone` | Map of VPCs to associate if it's a private zone | `map(object)` | No |
| <a name="input_route53_zone.private_zone.vpc_id"></a> `vpc_id` | ID of the VPC to associate | `string` | yes (if private) |
| <a name="input_route53_zone.private_zone.vpc_region"></a> `vpc_region` | Region of the associated VPC | `string` | yes (if private) |
| <a name="input_route53_record.key"></a> `key` | Name of the DNS record (e.g., `geo-india`) | `string` | yes|
| <a name="input_route53_record.hosted_zone_name"></a> `hosted_zone_name` | The domain name of the zone to associate (must exist in `route53_zone`) | `string` | yes|
| <a name="input_route53_record.zone_id"></a> `zone_id` | Optional hosted zone ID (used if not using the same module to create zone) | `string` | No|
| <a name="input_route53_record.type"></a> `type` | Record type (e.g., `A`, `CNAME`, etc.) | `string` | yes |
| <a name="input_route53_record.ttl"></a> `ttl` | Time to live (in seconds) | `number` | yes |
| <a name="input_route53_record.records"></a> `records` | List of record values (e.g., IPs or domain names) | `list(string)` | yes |
| <a name="input_route53_record.multi_value_answer_routing_policy"></a> `multi_value_answer_routing_policy` | Enable multi-value answer routing policy | `bool` | yes |
| <a name="input_route53_record.geolocation_routing_policy"></a> `geolocation_routing_policy` | Country or location-based routing | `list(object)` | No |
| <a name="input_route53_record.set_identifier"></a> `set_identifier` | Required when using geolocation/latency/weighted/failover routing | `string` | yes (if routing policy used) |
| <a name="input_route53_record.allow_overwrite"></a> `allow_overwrite` | Allow record to be overwritten if it already exists | `bool` | yes|

---

___


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_hosted_zones"></a> [route53_hosted_zones](#output_route53_hosted_zones) | Route53 hosted zones |
| <a name="output_route53_records"></a> [route53_records](#output_route53_records) | Route53 hosted zone's records |



## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)


