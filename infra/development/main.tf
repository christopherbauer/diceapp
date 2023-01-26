module "diceapp_ecs" {
  source      = "../core/ecs"
  environment = "development"
  vpc_id      = aws_vpc.this.id
}
 
