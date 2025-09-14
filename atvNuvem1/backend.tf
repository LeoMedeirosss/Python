terraform {
  backend "s3" {
    bucket = "terraform-lmf-hcmr-bucket"   # Nome do bucket S3 criado manualmente
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
