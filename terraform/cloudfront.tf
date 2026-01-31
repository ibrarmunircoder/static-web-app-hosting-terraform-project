
locals {
  s3_origin_id = aws_s3_bucket.hoobank_bucket.id
  domain_name  = "cooliodev.com"
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "hoobank-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "hoobank_app_distribution" {
  origin {
    domain_name              = aws_s3_bucket.hoobank_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["hoobank.${local.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", ]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    compress               = true
    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }


  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }
}

data "aws_route53_zone" "selected" {
  name         = local.domain_name
  private_zone = false
}
resource "aws_route53_record" "hoobank_cdn" {
  name    = "hoobank.${local.domain_name}"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id

  alias {
    name                   = aws_cloudfront_distribution.hoobank_app_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.hoobank_app_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
