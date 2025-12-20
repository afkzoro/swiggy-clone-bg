output "project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.app.name
}

output "project_arn" {
  description = "ARN of the CodeBuild project"
  value       = aws_codebuild_project.app.arn
}

output "role_arn" {
  description = "ARN of the CodeBuild IAM role"
  value       = aws_iam_role.codebuild_role.arn
}
