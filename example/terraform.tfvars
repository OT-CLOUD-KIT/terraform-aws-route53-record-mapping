route53_record = {
  "app-cname-record" = {
    hosted_zone_name = "non-prod.internal"
    type             = "CNAME"
    ttl              = 30
    zone_id          = "Z0717582NQWPOZWPE9C0"
    records          = ["d-ot-bp-alb-1365621129.us-east-1.elb.amazonaws.com"]
    multi_value_answer_routing_policy = true
    allow_overwrite = true
  }

  "geo-india" = {
    hosted_zone_name = "xyz.com"
    type             = "A"
    ttl              = 300
    records          = ["1.2.3.4"]
    geolocation_routing_policy = [{
      country = "IN"
    }]
    set_identifier   = "geo-india"
    allow_overwrite  = true
  }

  "geo-default" = {
    hosted_zone_name = "xyz.com"
    type             = "A"
    ttl              = 300
    records          = ["9.9.9.9"]
    geolocation_routing_policy = [{}]  
    set_identifier  = "geo-default"
    allow_overwrite = true
  }
}

route53_zone = {
  "non-prod.internal" = {
    comment = "non-prod internal private zone"
    tags = {
      Environment = "NonProd"
      ManagedBy   = "Terraform"
      Type   =  "Private"
    }
    private_zone = {
      "pw-nonprod-vpc" = {
        vpc_id     = "vpc-0584bf21acbf558a1"
        vpc_region = "us-east-1"
      }
    }
  }

  "xyz.com" = {
    comment = "xyz public hosted zone"
    tags = {
      ManagedBy = "Terraform"
      Name      = "XYZ"
      Type      = "Public"
    }
  }
}