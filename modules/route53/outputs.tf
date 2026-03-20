output "record_fqdn" {
  description = "Fully qualified domain name of the record"
  value       = var.create_alias ? aws_route53_record.alias[0].fqdn : aws_route53_record.records[0].fqdn
  depends_on  = [aws_route53_record.alias, aws_route53_record.records]
}

output "record_name" {
  description = "The name of the Route53 record"
  value       = var.record_name
}
