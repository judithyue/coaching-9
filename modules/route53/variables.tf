variable "zone_id" {
  description = "Route53 Hosted Zone ID where the record will be created (optional if zone_name is provided)"
  type        = string
  default     = ""
}

variable "zone_name" {
  description = "Route53 Hosted Zone name (e.g., example.com) used to lookup the zone ID when zone_id is not provided"
  type        = string
  default     = ""

  validation {
    condition     = var.zone_id != "" || var.zone_name != ""
    error_message = "Either zone_id or zone_name must be set."
  }
}

variable "aws_region" {
  description = "AWS region where the alias target resides (used to auto-select S3 website alias zone ID)"
  type        = string
  default     = ""
}

/*
variable "alias_zone_id_map" {
  description = "Fallback map of region (or other key) to alias hosted zone ID."

# When alias_zone_id is not provided, the module will attempt to derive the correct
# zone ID using this map and the provided aws_region. Useful for S3 website endpoints."
  type        = map(string)
  default = {
    # IMPORTANT: These are hosted zone IDs for S3 WEBSITE endpoints (not S3 REST API endpoints)
    # S3 website endpoints use different zone IDs than regular S3 endpoints
    # S3 website endpoints
    "us-east-1"      = "Z3AQBSTGFYJSTF"
    "us-east-2"      = "Z2O1EMRO9K5GLX"
    "us-west-1"      = "Z2F56UZL2M1ACD"
    "us-west-2"      = "Z3BJ6K6RIION7M"
    "ap-south-1"     = "Z11RGJOFQNVJUP"
    # S3 website endpoints (not the regular S3 REST endpoint zone IDs)
    "ap-southeast-1" = "Z3O0J2DXBE1FTB"  # Singapore website endpoint
    "ap-southeast-2" = "Z2WC2B114PQLBE"  # Sydney website endpoint
    "ap-northeast-1" = "Z2M4EHUR26P7ZW"
    "ap-northeast-2" = "Z3W03O7B5YMIYP"
    "ca-central-1"   = "Z1QDHH18159H29"
    "eu-central-1"   = "Z21DNDUVLTQW6Q"
    "eu-west-1"      = "Z1BKCTXD74EZPE"
    "eu-west-2"      = "Z3GKZC51ZF0DB4"
    "eu-west-3"      = "Z3R1K369G5AVDG"
    "sa-east-1"      = "Z7KQH4QJS55SO"

    # Common alias targets
    "cloudfront"     = "Z2FDTNDATAQYW2"
  }
}
*/

variable "record_name" {
  description = "The DNS name for the record (FQDN or relative name), like jus3.sctp-sandbox.com"
  type        = string
}

variable "record_type" {
  description = "DNS record type (A, AAAA, CNAME, etc.)"
  type        = string
  default     = "A"
}

variable "ttl" {
  description = "TTL (seconds) for non-alias records"
  type        = number
  default     = 300
}

variable "records" {
  description = "Address records for non-alias mode (e.g. [\"1.2.3.4\"])"
  type        = list(string)
  default     = []
}

variable "create_alias" {
  description = "When true, creates an Alias record instead of setting specific address records"
  type        = bool
  default     = false
}

variable "alias_target" {
  description = "The target DNS name for the alias record (e.g. an S3 website endpoint or CloudFront domain)"
  type        = string
  default     = ""
}

variable "alias_zone_id" {
  description = "The hosted zone ID of the alias target (required for alias records)"
  type        = string
  default     = ""
}

variable "evaluate_target_health" {
  description = "Whether Route53 should evaluate the health of the alias target"
  type        = bool
  default     = false
}
