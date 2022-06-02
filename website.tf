locals {
  sse-s3-encrytion-algorithm     = "AES256"
}

# S3 bucket
resource "aws_s3_bucket" "content" {
  tags = {
    Name = "My bucket"
  }
}

# S3 bucket policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.content.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cf_oai.iam_arn]
    }
  }
}

# policy assign to s3
resource "aws_s3_bucket_policy" "content_bucket_policy" {
  bucket = aws_s3_bucket.content.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

# acl for bucket
resource "aws_s3_bucket_acl" "content_acl" {
  bucket = aws_s3_bucket.content.id
  acl    = "private"
}

# encryption config at bucket level
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_key_config" {
  bucket = aws_s3_bucket.content.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = local.sse-s3-encrytion-algorithm
    }
  }
}

# index.html object to S3 and object level encryption
resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.content.bucket
  key          = "index.html"
  source       = "content/index.html"
  content_type = "text/html"
  server_side_encryption = local.sse-s3-encrytion-algorithm
}

# 404.html object to S3 and object level encryption
resource "aws_s3_object" "error_404_page" {
  bucket       = aws_s3_bucket.content.bucket
  key          = "404.html"
  source       = "content/404.html"
  content_type = "text/html"
  server_side_encryption = local.sse-s3-encrytion-algorithm
}