
variable "context" {
  description = "This variable contains Radius recipe context."

  type = any
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}