data "aws_acm_certificate" "acm-certificate" {
  domain = data.aws_route53_zone.route53-zone.name
}


resource "aws_cloudfront_distribution" "cloudfront-distribution" {
  origin {
    domain_name = aws_s3_bucket.s3-bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.s3-bucket.arn

  }
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.object-static

  default_cache_behavior {
    allowed_methods        = var.allowed-method
    cached_methods         = var.cached-method
    target_origin_id       = aws_s3_bucket.s3-bucket.arn
    viewer_protocol_policy = var.viewer_protocol_policy

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

  }
  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = data.aws_acm_certificate.acm-certificate.arn
    ssl_support_method             = var.ssl-viewer-certificate
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  aliases = ["rinku-capstone-record.dns-poc-onprem.tk"]

  tags = {
    "Name"  = "${var.tag-name}-cloudfront"
    "Owner" = var.tag-owner
  }
}