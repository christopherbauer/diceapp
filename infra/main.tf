provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "corporate" {
  source = "./corporate"
}
module "development" {
  source                       = "./development"
  iam_container_management_arn = aws_iam_role.container_management.arn
  diceapp_registry_url         = module.corporate.diceapp_ecr_url
}
module "production" {
  source = "./production"
}
