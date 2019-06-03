provider "aws" {
  profile = "sre"
  region  = "eu-central-1"
  version = "~> 2.0"
}

resource "aws_s3_bucket" "bitelio-com" {
  bucket = "bitelio.com"
  region = "eu-central-1"
  website {
    index_document = "index.html"
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::bitelio.com/*"
    }
  ]
}
POLICY

}

resource "aws_s3_bucket" "www-bitelio-com" {
  bucket = "www.bitelio.com"
  website {
    redirect_all_requests_to = "https://bitelio.com"
  }
}

resource "aws_route53_zone" "bitelio-com-public" {
  name = "bitelio.com"
  comment = ""
}

resource "aws_route53_record" "bitelio-com-A" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "A"

  alias {
    name = "d1ne4wzzp1ik1q.cloudfront.net"
    zone_id = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "bitelio-com-NS" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "NS"
  records = ["ns-1778.awsdns-30.co.uk.", "ns-934.awsdns-52.net.", "ns-1478.awsdns-56.org.", "ns-429.awsdns-53.com."]
  ttl = "172800"
}

resource "aws_route53_record" "bitelio-com-SOA" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "SOA"
  records = ["ns-1478.awsdns-56.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl = "900"
}

resource "aws_route53_record" "_40cdaec37a94cd19808135404a224015-bitelio-com-CNAME" {
  zone_id = "Z55UFJUSNXP2N"
  name = "_40cdaec37a94cd19808135404a224015.bitelio.com"
  type = "CNAME"
  records = ["_af76a6f80848ff7abfcc1aa11990dc9c.hkvuiqjoua.acm-validations.aws."]
  ttl = "300"
}

resource "aws_route53_record" "www-bitelio-com-A" {
  zone_id = "Z55UFJUSNXP2N"
  name = "www.bitelio.com"
  type = "A"

  alias {
    name = "d1ne4wzzp1ik1q.cloudfront.net"
    zone_id = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "_316cf624d6e0ae3892468c01c5afff41-www-bitelio-com-CNAME" {
  zone_id = "Z55UFJUSNXP2N"
  name = "_316cf624d6e0ae3892468c01c5afff41.www.bitelio.com"
  type = "CNAME"
  records = ["_42ae1ec0157ae4c7d45676813e31ab66.hkvuiqjoua.acm-validations.aws."]
  ttl = "300"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  aliases = ["www.bitelio.com", "bitelio.com"]
  default_root_object = "index.html"
  is_ipv6_enabled = true
  origin {
    domain_name = aws_s3_bucket.bitelio-com.bucket_regional_domain_name
    origin_id = "S3-bitelio"
  }
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "S3-bitelio"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
  }
  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:561291244739:certificate/b2a1a1fe-6189-415b-b34c-29fbafed3551"
    ssl_support_method = "sni-only"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

