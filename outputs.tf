output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_static_website.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_static_website.bucket_arn
}

output "s3_bucket_region" {
  description = "The AWS region where the bucket is located"
  value       = module.s3_static_website.bucket_region
}

output "s3_bucket_domain_name" {
  description = "The bucket domain name"
  value       = module.s3_static_website.bucket_domain_name
}

output "s3_website_endpoint" {
  description = "The s3website endpoint for the static site with bucket name and region (e.g. bucket-name.s3-website-region.amazonaws.com)"
  value       = module.s3_static_website.website_endpoint
}

output "aws_s3_website_domain" {
  description = "The aws s3 website domain name, also known as alias target/name for Route53"
  value       = module.s3_static_website.website_domain
}

output "s3_website_url" {
  description = "The s3 bucket public website url"
  value = module.s3_static_website.website_url
}

output "bucket_hosted_zone_id" {
  description = "The hosted zone ID for the bucket's website endpoint (used for Route53 alias records)"
  value       = module.s3_static_website.bucket_hosted_zone_id
}

output "dns_record_fqdn" {
  description = "The full DNS record name created in Route53 (if enabled)"
  value       = try(module.route53[0].record_fqdn, "")
}
