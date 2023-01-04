provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "corporate" {
  source = "./corporate"
}
module "development" {
  source = "./development"
}
module "production" {
  source = "./production"
}