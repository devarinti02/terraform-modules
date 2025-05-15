terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = ""
    key = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}


module "ec2" {
  source = "./modules/EC2"
}

module "s3_bucket" {
  source = ./modules/S3-Bucket
}
