# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.app_name}"
  retention_in_days = 7

  tags = {
    Name = "${var.project_name}-${var.app_name}-logs"
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = var.app_name
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_execution_role_arn
  
  container_definitions = jsonencode([{
    name      = var.app_name
    image     = "${var.docker_image}:latest"
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 0
      protocol      = "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.app.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  tags = {
    Name = "${var.project_name}-${var.app_name}-task"
  }
}

# ECS Service
resource "aws_ecs_service" "app" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "EC2"

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.app_name
    container_port   = 3000
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count,
      load_balancer
    ]
  }

  tags = {
    Name = "${var.project_name}-${var.app_name}-service"
  }
}