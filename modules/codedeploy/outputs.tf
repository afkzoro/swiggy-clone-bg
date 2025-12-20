output "app_name" {
  description = "Name of the CodeDeploy application"
  value       = aws_codedeploy_app.ecs.name
}

output "deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.ecs.deployment_group_name
}

output "deployment_group_id" {
  description = "ID of the CodeDeploy deployment group"
  value       = aws_codedeploy_deployment_group.ecs.id
}
