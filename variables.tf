
variable "context" {
  description = "This variable contains Radius recipe context."

  type = any
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "iam_user_arn" {
  description = "iam user arn"
  type = string
}

variable "policy" {
  Id= "Policy34123478"
  Version= "2012-10-17"
  Statement= [
    {
      Sid= "Stmt34123478"
      Action= [
        "s3:ListBucket"
      ]
      Effect= "Allow"
      Resource= module.s3_bucket.properties.Arn
      Principal= {
        AWS: [
          var.iam_user_arn
        ]
      }
    }
  ]
}