output "bucket_name" {
  value = aws_s3_bucket.content.bucket
}

output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
