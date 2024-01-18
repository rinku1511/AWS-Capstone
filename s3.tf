resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.bucket-name

  tags = {
    "Name"  = "${var.tag-name}-bucket"
    "Owner" = var.tag-owner
  }
}

resource "aws_s3_bucket_acl" "s3-bucket-acl" {
  acl        = "public-read"
  bucket     = aws_s3_bucket.s3-bucket.id
  depends_on = [aws_s3_bucket.s3-bucket]
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  policy     = data.aws_iam_policy_document.iam-policy-for-s3.json
  bucket     = aws_s3_bucket.s3-bucket.id
  depends_on = [aws_s3_bucket.s3-bucket]
}

resource "aws_s3_bucket_public_access_block" "public-access-block" {
  block_public_acls       = false
  bucket                  = aws_s3_bucket.s3-bucket.id
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
  depends_on              = [aws_s3_bucket.s3-bucket]
}

resource "aws_s3_object" "s3-object" {
  bucket       = aws_s3_bucket.s3-bucket.id
  key          = var.bucket-object
  source       = var.s3-source
  depends_on   = [aws_s3_bucket.s3-bucket]
  content_type = var.content_type
}

resource "aws_s3_bucket_website_configuration" "s3-bucket-website-configuration" {
  bucket = aws_s3_bucket.s3-bucket.id
  index_document {
    suffix = "index.html"
  }
  depends_on = [aws_s3_bucket.s3-bucket]
}

data "aws_iam_policy_document" "iam-policy-for-s3" {

  statement {

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [aws_s3_bucket.s3-bucket.arn, "${aws_s3_bucket.s3-bucket.arn}/*"]
  }
}