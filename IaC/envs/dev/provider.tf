terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.28.0"
    }
  }

  backend "s3" {
    bucket = "test-terraform-state-sdfgdfg"
    key    = "terraform-state-dev.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west-3"
}
