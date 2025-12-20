resource "aws_codedeploy_app" "ecs" {
  compute_platform = "ECS"
  name             = "${var.project_name}-app"
}

resource "aws_codedeploy_deployment_group" "ecs" {
  app_name               = aws_codedeploy_app.ecs.name
  deployment_group_name  = "${var.project_name}-dg"
  service_role_arn       = var.codedeploy_role_arn
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
  
  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
  
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
  
  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }
  
  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.alb_listener_arn]
      }
      
      target_group {
        name = var.blue_target_group_name
      }
      
      target_group {
        name = var.green_target_group_name
      }
    }
  }
}