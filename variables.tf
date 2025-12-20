variable "region" {
  description = "Default AWS region"
  type = string
}

variable "vpc_cidr" {
  description = "Swiggy Clone VPC CIDR"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
}

variable "public_subnets" {
  description = "Map of public subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    map_public_ip     = bool
  }))
}

variable "private_subnets" {
  description = "Map of private subnets"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type = bool
  default = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all private subnets"
  type = bool
  default = false
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type = bool
  default = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type = bool
  default = true
}

variable "sonar_token" {
  description = "Sonarqube token"
  type = string
}

variable "docker_username" {
  description = "Docker username"
  type = string
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "swiggy-app"
}

variable "docker_image" {
  description = "Docker image repository for the application"
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

variable "codestar_connection_arn" {
  description = "ARN of the CodeStar connection for GitHub (create manually in AWS Console)"
  type        = string
}