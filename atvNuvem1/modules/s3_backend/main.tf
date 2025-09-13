variable "aws_region" { type = string }
variable "bucket_name" { type = string }
variable "tags" { type = map(string) }

provider "aws" { region = var.aws_region }

resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name
  acl    = "private"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "tfstate_ver" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.tfstate.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
