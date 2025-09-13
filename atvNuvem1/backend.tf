terraform {
  backend "s3" {
    bucket = var.backend_bucket
    key    = "terraform.tfstate"
    region = var.aws_region
    encrypt = true
  }
}
