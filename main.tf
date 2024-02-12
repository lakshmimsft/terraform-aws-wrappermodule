terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"  # Replace with your desired region
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid    = "Stmt34123478"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      module.s3_bucket.s3_bucket_arn,
    ]
    principals {
      type        = "AWS"
      identifiers = [var.iam_user_arn]
    }
  }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket = var.bucket_name

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"
  expected_bucket_owner    = data.aws_caller_identity.current.account_id
  acl                      = "public-read"

  attach_policy = true
  policy = data.aws_iam_policy_document.s3_policy.json

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET"]
      allowed_origins = ["https://my-app.domain.com"]
      max_age_seconds = 3000
    }
  ]
}
