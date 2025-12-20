variable "project_name" {
  description = "Project name"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "ARN of the IAM role for CodeDeploy"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener"
  type        = string
}

variable "blue_target_group_name" {
  description = "Name of the blue target group"
  type        = string
}

variable "green_target_group_name" {
  description = "Name of the green target group"
  type        = string
}
