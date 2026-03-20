# Route53 record (supports normal records or alias records)
#
# This module can create a record in a given Hosted Zone.
# Use `create_alias = true` to create an alias record (e.g. to an S3 website endpoint or CloudFront distribution).
#
# If `zone_id` is not provided, the module will look up the zone by `zone_name`.

data "aws_route53_zone" "target" {
  count = var.zone_id == "" ? 1 : 0
  name  = var.zone_name
}

locals {
  zone_id = var.zone_id != "" ? var.zone_id : data.aws_route53_zone.target[0].zone_id
  create_alias_effective = var.create_alias
}

resource "aws_route53_record" "alias" {
  count   = local.create_alias_effective ? 1 : 0
  zone_id = local.zone_id
  name    = var.record_name
  type    = var.record_type

  alias {
    name                   = var.alias_target
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

resource "aws_route53_record" "records" {
  count   = local.create_alias_effective ? 0 : 1
  zone_id = local.zone_id
  name    = var.record_name
  type    = var.record_type
  ttl     = var.ttl

  records = var.records
}

