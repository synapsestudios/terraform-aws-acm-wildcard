variable "dns_zone" {
  type        = string
  description = "Name of the DNS zone to use with this deployment."
}

variable "aws_assume_role_arn" {
  type        = string
  description = "ARN of the AWS role to assume when running this deployment."
}
