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
  ttl     = "3600"
  records = [
    "0 issue \"amazon.com\"",
    "0 issuewild \"amazon.com\"",
  ]
}

resource "aws_route53_record" "_40cdaec37a94cd19808135404a224015-bitelio-com-CNAME" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "_40cdaec37a94cd19808135404a224015.bitelio.com"
  type    = "CNAME"
  records = ["_af76a6f80848ff7abfcc1aa11990dc9c.hkvuiqjoua.acm-validations.aws."]
  ttl     = "300"
}

resource "aws_route53_record" "_316cf624d6e0ae3892468c01c5afff41-www-bitelio-com-CNAME" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "_316cf624d6e0ae3892468c01c5afff41.www.bitelio.com"
  type    = "CNAME"
  records = ["_42ae1ec0157ae4c7d45676813e31ab66.hkvuiqjoua.acm-validations.aws."]
  ttl     = "300"
}
