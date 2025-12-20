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