
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}
