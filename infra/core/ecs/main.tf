resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-${var.app_name}"
}
resource "aws_ecs_service" "this" {
  name            = "deployment"
  task_definition = aws_ecs_task_definition.this.arn
  cluster         = aws_ecs_cluster.this.id
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    assign_public_ip = true
    security_groups = [
      var.egress_security_group_id, var.ingress_security_group_id
    ]
    subnets = [
      aws_subnet.public_a.id,
      aws_subnet.private_a.id,
      aws_subnet.public_b.id,
      aws_subnet.private_b.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.app_name
    container_port   = var.container_port
  }
}
resource "aws_ecs_task_definition" "this" {
  family                   = "${var.app_name}_provisioning"
  execution_role_arn       = var.iam_container_management_arn
  task_role_arn            = var.iam_container_management_arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      "name" : var.app_name,
      "image" : var.image_name,
      "portMappings" : [{
        containerPort : var.container_port
      }],
      "environment" : var.environment_variables,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-region" : var.region,
          "awslogs-group" : "fargate-logs",
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" : "${var.app_name}-ecs"
        }
      }
    }
  ])
  tags = {
    Environment = var.environment
    Service     = "deployment"
  }
}