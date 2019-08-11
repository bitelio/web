resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  aliases             = ["bitelio.com", "www.bitelio.com"]
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  origin {
    domain_name = aws_s3_bucket.bitelio-com.bucket_regional_domain_name
    origin_id   = "S3-bitelio"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-bitelio"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:561291244739:certificate/b2a1a1fe-6189-415b-b34c-29fbafed3551"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }
}
