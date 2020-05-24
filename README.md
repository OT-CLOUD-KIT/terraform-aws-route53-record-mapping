AWS Route53 Records mapping Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module for Route53 Records mapping on AWS.

These types of resources are supported:

* [route53_record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)

Terraform versions
------------------

Terraform 0.12.

Usage
------

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "records" {
  source                  = "../route53_records_mapping"
  dns_names               = ["helloworld1", "hellowold2"]
  rout53_record_type      = "A"
  zone_id                 = ""
  ttl                     = "60"
  records                 = ["10.0.0.1", "10.0.0.2"]
}

```

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns_name | Define dns name  | `list(string)` | `"false"` | yes |
| route53_record_type | Define record type   | `string` | `"CNAME"` | no |
| zone_id | You can define the zone_id | `string` | `"false"` | yes |
| ttl | define time in seconds to records entry in DNS severe | `string` | `"false"` | yes |
| records | Define the records to map  | `list(string)` | `"false"` | yes |


## Related Projects

Check out these related projects.

- [security_group](https://github.com/OT-CLOUD-KIT/terraform-aws-network-skeleton) - Terraform module for creating dynamic Security 

### Contributors

[![Devesh Sharma][devesh_avataar]][devesh_homepage]<br/>[Devesh Sharma][devesh_homepage] 

  [devesh_homepage]: https://github.com/deveshs23
  [devesh_avataar]: https://img.cloudposse.com/75x75/https://github.com/deveshs23.png