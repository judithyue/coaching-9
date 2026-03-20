variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-southeast-1"
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "static-website"
}

variable "env" {
  description = "Environment name (prod, staging, dev)"
  type        = string
  default     = "prod"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for static website"
  type        = string
}

variable "index_document" {
  description = "Name of the index document"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document"
  type        = string
  default     = "error.html"
}

variable "bucket_acl" {
  description = "ACL for the bucket"
  type        = string
  default     = "private"
}

variable "object_ownership" {
  description = "Object ownership setting"
  type        = string
  default     = "BucketOwnerEnforced"
}

# Public Access Block Settings
variable "block_public_acls" {
  description = "Block public ACLs"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Ignore existing public ACLs"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Restrict public bucket access"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"
}

# Route53 DNS settings
variable "route53_zone_id" {
  description = "Route53 hosted zone ID for the record (optional if route53_zone_name is provided)"
  type        = string
  default     = ""
}

variable "route53_zone_name" {
  description = "Route53 hosted zone name (e.g., example.com) used to lookup the zone ID when route53_zone_id is not provided"
  type        = string
  default     = ""
}

variable "route53_record_name" {
  description = "DNS record name to create (FQDN or relative name)"
  type        = string
  default     = ""
}

variable "route53_record_type" {
  description = "DNS record type"
  type        = string
  default     = "A"
}

variable "route53_ttl" {
  description = "TTL (seconds) for non-alias records"
  type        = number
  default     = 300
}

variable "route53_records" {
  description = "List of record values for non-alias mode"
  type        = list(string)
  default     = []
}

variable "route53_create_alias" {
  description = "Whether to create an alias record (required for S3 website endpoints)"
  type        = bool
  default     = false
}

variable "route53_alias_zone_id" {
  description = "Hosted zone ID of the alias target (required when create_alias=true)"
  type        = string
  default     = ""
}

variable "route53_evaluate_target_health" {
  description = "Whether Route53 should evaluate the health of the alias target"
  type        = bool
  default     = false
}
