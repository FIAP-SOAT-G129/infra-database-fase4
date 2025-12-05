terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }

    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "mongodbatlas" {
  client_id     = var.mongo_client_id
  client_secret = var.mongo_client_secret
}
