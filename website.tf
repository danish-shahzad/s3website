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

# to encrypt object within S3
resource "aws_kms_key" "encryption_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# encryption config
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_key_config" {
  bucket = aws_s3_bucket.content.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.encryption_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# index.html object to S3
resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.content.bucket
  key          = "index.html"
  source       = "content/index.html"
  content_type = "text/html"
}





