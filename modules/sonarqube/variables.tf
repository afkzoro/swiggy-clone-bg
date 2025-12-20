variable "vpc_id" {
  description = "VPC ID where SonarQube instance will be deployed"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for SonarQube instance"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}