module "diceapp_ecs" {
  source                           = "../core/ecs"
  environment                      = "development"
  vpc_id                           = aws_vpc.this.id
  app_name                         = "diceapp"
  availability_zone_1              = "us-east-2a"
  public_availability_zone_1_cidr  = "10.2.0.0/24"
  private_availability_zone_1_cidr = "10.2.1.0/24"
  availability_zone_2              = "us-east-2b"
  public_availability_zone_2_cidr  = "10.2.2.0/24"
  private_availability_zone_2_cidr = "10.2.3.0/24"

  iam_container_management_arn = var.iam_container_management_arn
  image_name                   = "${var.diceapp_registry_url}:development"
  container_port               = 3000

  egress_security_group_id  = aws_security_group.egress_all.id
  ingress_security_group_id = aws_security_group.ingress_api.id
  http_security_group_id    = aws_security_group.http.id
  https_security_group_id   = aws_security_group.https.id

  internet_gateway_id = aws_internet_gateway.this.id
  log_region          = "us-east-1"

  instance_memory = "1024"
  instance_cpu    = 256
  environment_variables = [
    { "name" : "PORT", "value" : "3000" }
  ]
}

