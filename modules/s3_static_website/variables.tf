variable "bucket_name" {
  description = "Name of the S3 bucket for static website"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.bucket_name)) && length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "Bucket name must be between 3 and 63 characters, start and end with lowercase letter or number, and contain only lowercase letters, numbers, hyphens, and periods."
  }
}

variable "env" {
  description = "Name of the environment"
  type        = string
}

variable "index_document" {
  description = "Name of the index document for the static website"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "Name of the error document for the static website"
  type        = string
  default     = "error.html"
}

variable "bucket_acl" {
  description = "ACL for the bucket (used with ObjectOwnership = BucketOwnerFullControl)"
  type        = string
  default     = "public-read"

  validation {
    condition     = contains(["private", "public-read", "public-read-write", "aws-exec-read", "authenticated-read", "bucket-owner-read", "bucket-owner-full-control", "log-delivery-write"], var.bucket_acl)
    error_message = "ACL must be a valid S3 ACL value."
  }
}

variable "object_ownership" {
  description = "Object ownership control (BucketOwnerFullControl, ObjectWriter, BucketOwnerEnforced)"
  type        = string
  default     = "BucketOwnerEnforced"

  validation {
    condition     = contains(["BucketOwnerFullControl", "ObjectWriter", "BucketOwnerEnforced"], var.object_ownership)
    error_message = "Object ownership must be one of: BucketOwnerFullControl, ObjectWriter, or BucketOwnerEnforced."
  }
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether to block public bucket policies"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether to ignore existing public ACLs"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public bucket access"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "encryption_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.encryption_algorithm)
    error_message = "Encryption algorithm must be either AES256 or aws:kms."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Project   = "S3StaticWebsite"
  }
}
