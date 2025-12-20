terraform {
    required_version = ">=1.14.3"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">=6.22.1"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.0"
        }
    }      
}

provider "aws" {
  region = var.region
}