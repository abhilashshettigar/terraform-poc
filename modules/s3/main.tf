data "aws_caller_identity" "account" {

}


resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}


resource "aws_s3_bucket" "s3Bucket" {
  bucket = random_string.random.result

  tags = {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}


data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = ["${aws_s3_bucket.s3Bucket.arn}/*", "${aws_s3_bucket.s3Bucket.arn}"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.s3Bucket.arn}/*", "${aws_s3_bucket.s3Bucket.arn}"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.account.account_id}:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3BucketPolicy" {
  bucket = aws_s3_bucket.s3Bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3BucketEncryption" {
  bucket = aws_s3_bucket.s3Bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "s3BucketOwnership" {
  bucket = aws_s3_bucket.s3Bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
