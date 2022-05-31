terraform {
  required_providers {
    aws = {
      version = "4.16.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
}