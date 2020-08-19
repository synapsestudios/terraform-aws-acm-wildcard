##########################
# AWS Provider - us-east-1
##########################
provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"

  assume_role {
    role_arn     = var.aws_assume_role_arn
    session_name = "terraform-acm-wildcard"
  }
}

##########################
# AWS Provider - us-west-2
##########################
provider "aws" {
  region = "us-west-2"
  alias  = "us-west-2"

  assume_role {
    role_arn     = var.aws_assume_role_arn
    session_name = "terraform-acm-wildcard"
  }
}

##################
# Route53 DNS Zone
##################
data "aws_route53_zone" "this" {
  name         = var.dns_zone
  private_zone = false
}

##################################################################
# ACM - Wildcard SSL Certifcate for Environment (US-EAST-1 Region)
##################################################################
resource "aws_acm_certificate" "us_east_1" {
  domain_name               = "*.${var.dns_zone}"
  subject_alternative_names = [var.dns_zone]
  validation_method         = "DNS"
  provider                  = aws.us-east-1

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "us_east_1" {
  certificate_arn         = aws_acm_certificate.us_east_1.arn
  validation_record_fqdns = [aws_route53_record.validation.fqdn]
  provider                = aws.us-east-1
}

##################################################################
# ACM - Wildcard SSL Certifcate for Environment (US-WEST-2 Region)
##################################################################
resource "aws_acm_certificate" "us_west_2" {
  domain_name               = "*.${var.dns_zone}"
  subject_alternative_names = [var.dns_zone]
  validation_method         = "DNS"
  provider                  = aws.us-west-2

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "us_west_2" {
  certificate_arn         = aws_acm_certificate.us_west_2.arn
  validation_record_fqdns = [aws_route53_record.validation.fqdn]
  provider                = aws.us-west-2
}

###########################
# Route53 Validation Record
###########################
resource "aws_route53_record" "validation" {
  name     = aws_acm_certificate.us_east_1.domain_validation_options.0.resource_record_name
  type     = aws_acm_certificate.us_east_1.domain_validation_options.0.resource_record_type
  zone_id  = data.aws_route53_zone.this.id
  records  = [aws_acm_certificate.us_east_1.domain_validation_options.0.resource_record_value]
  ttl      = 60
  provider = aws.us-east-1
}
