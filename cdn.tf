//Declaring a Local Value
locals {
  s3_origin_id = "myS3Origin"
}

//Create Cloudfront distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.content.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "S3 Static Webstie CloudFront Distribution..."
  default_root_object = "index.html"

  custom_error_response {
    error_code         = 403
    response_code      = 404
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    #HTTP requests are automatically redirected to HTTPS requests.
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  #No restriction - can be accessed from anywhere in the world.
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  //CloudFront distribution to use an SSL/TLS certificate  - Default certificate
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
