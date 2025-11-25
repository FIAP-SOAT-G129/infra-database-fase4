terraform {
  backend "s3" {
    bucket = "fastfood-tf-states"
    key    = "infra/database/terraform.tfstate"
    region = "us-east-1"
  }
}
