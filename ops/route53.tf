resource "aws_route53_zone" "primary" {
  name = "bitelio.com"
}

resource "aws_route53_record" "bitelio-com-A" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "bitelio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-bitelio-com-A" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.bitelio.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "bitelio.com."
  type    = "CAA"
  ttl     = 3600
  records = [
    "0 issue \"amazon.com\"",
    "0 issuewild \"amazon.com\"",
  ]
}

resource "aws_route53_record" "certificate_validation" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = aws_acm_certificate.certificate.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.certificate.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.certificate.domain_validation_options[0].resource_record_value]
  ttl     = 300
}
