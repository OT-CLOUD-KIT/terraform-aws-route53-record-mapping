variable "zone_id" {
  description = "Name of private hosted zone id"
  type        = string
}

variable "dns_names" {
  description = "Name of dns name"
  type        = list(string)
}

variable "rout53_record_type" {
  type    = string
  default = "CNAME"
}

variable "records_name" {
  type = list(string)
}

variable "ttl" {
  description = "Time to live"
  type        = string
  default     = "60"
}
