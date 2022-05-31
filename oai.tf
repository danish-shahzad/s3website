# Cloudfront OAI - Restricting access to Amazon S3 content by using an origin access identity (OAI)
resource "aws_cloudfront_origin_access_identity" "cf_oai" {
  comment = "CloudFront OAI"
}
