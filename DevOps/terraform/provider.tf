# Provider Configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Name        = "KPMG"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "mayank-kpmg-terraform-bucket"
    key = "prod/production.tfstate"
    region = "eu-west-2"
  }
}
