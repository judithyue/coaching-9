terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.env
      ManagedBy   = "Terraform"
    }
  }
}

module "s3_static_website" {
  source = "./modules/s3_static_website"

  bucket_name = var.bucket_name

  # Static website configuration
  index_document = var.index_document
  error_document = var.error_document

  # Public access settings - set to false to allow public access
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  # Bucket configuration
  bucket_acl       = var.bucket_acl
  object_ownership = var.object_ownership

  # Security settings
  enable_versioning    = var.enable_versioning
  encryption_algorithm = var.encryption_algorithm

  env = var.env

  common_tags = {
    Project = var.project_name
    Website = "Static"
  }
}

module "route53" {
  source = "./modules/route53"

  count = (var.route53_zone_id != "" || var.route53_zone_name != "") ? 1 : 0

  zone_id     = var.route53_zone_id
  zone_name   = var.route53_zone_name
  aws_region  = var.aws_region
  record_name = var.route53_record_name
  record_type = var.route53_record_type
  ttl         = var.route53_ttl

  # If you want DNS to point to the S3 bucket website endpoint, enable alias mode.
  create_alias           = var.route53_create_alias
  alias_target           = module.s3_static_website.website_domain
  alias_zone_id          = module.s3_static_website.bucket_hosted_zone_id #var.route53_alias_zone_id
  evaluate_target_health = var.route53_evaluate_target_health

  # If not using alias, set records
  records = var.route53_records
}
