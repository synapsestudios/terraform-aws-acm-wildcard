output "us_east_1_acm_certificate_arn" {
  description = "ARN of the wildcard certificate in us-east-1, for CloudFront."
  value       = aws_acm_certificate.us_east_1.arn
}

output "us_west_2_acm_certificate_arn" {
  description = "ARN of the wildcard certificate in us-west-2."
  value       = aws_acm_certificate.us_west_2.arn
}
