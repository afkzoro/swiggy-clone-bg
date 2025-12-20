variable "project_name" {
  description = "Project name"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Name of the S3 bucket for artifacts"
  type        = string
}

variable "artifact_bucket_arn" {
  description = "ARN of the S3 bucket for artifacts"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "codebuild_project_arn" {
  description = "ARN of the CodeBuild project"
  type        = string
}

variable "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  type        = string
}

variable "codedeploy_deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  type        = string
}

variable "codestar_connection_arn" {
  description = "ARN of the CodeStar connection for GitHub"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in format owner/repo"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to deploy from"
  type        = string
  default     = "main"
}
