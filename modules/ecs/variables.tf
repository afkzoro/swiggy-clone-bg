variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS cluster will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS instances"
  type        = list(string)
}

variable "ecs_instance_profile_name" {
  description = "Name of the IAM instance profile for ECS instances"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group for ECS instances"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
  default     = ""
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "docker_image" {
  description = "Docker image for the application"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}