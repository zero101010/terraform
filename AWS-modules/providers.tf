terraform {
  required_version = ">=0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.54.0"
    }
    local = ">=2.1.0"
  }
  backend "s3" {
    bucket = "full-cycle"
    key = "terraform.tfstate"
    region = "us-east-1"
    
  }
}

provider "aws" {
  region = "us-east-1"
}
