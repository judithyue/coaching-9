output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "bucket_region" {
  description = "The AWS region where the bucket is located"
  value       = aws_s3_bucket.website.region
}

output "bucket_domain_name" {
  description = "The bucket domain name (can be used with CNAME)"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "website_endpoint" {
  description = "The website endpoint URL for the static website"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_domain" {
  description = "The domain name of the website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}

output "website_url" {
  description = "The URL to access the static website"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "bucket_hosted_zone_id" {
  description = "The hosted zone ID for the bucket's website endpoint (used for Route53 alias records)"
#  value       = aws_s3_bucket_website_configuration.website.hosted_zone_id
  value       = aws_s3_bucket.website.hosted_zone_id
}
