module "vpc" {
  source = "./modules/vpc"

  region               = var.region
  vpc_cidr            = var.vpc_cidr
  project_name        = var.project_name
  availability_zones  = var.availability_zones
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets
  enable_nat_gateway  = var.enable_nat_gateway
  single_nat_gateway  = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
}

module "iam" {
  source = "./modules/iam"
  project_name = var.project_name
}

module "s3" {
  source = "./modules/s3"
  project_name = var.project_name
}

module "ssm" {
  source = "./modules/ssm"
  docker_username = var.docker_username
  docker_password = var.docker_password
  sonar_token = var.sonar_token
}

module "sonarqube" {
  source = "./modules/sonarqube"
  
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_ids[0]
  key_pair_name     = var.key_pair_name
  project_name      = var.project_name
  
  depends_on = [module.vpc]
}

module "alb" {
  source = "./modules/alb"
  
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  project_name       = var.project_name
  
  depends_on = [module.vpc]
}

module "ecs" {
  source = "./modules/ecs"
  
  project_name               = var.project_name
  vpc_id                     = module.vpc.vpc_id
  private_subnet_ids         = module.vpc.private_subnet_ids
  ecs_instance_profile_name  = module.iam.ecs_instance_profile_name
  alb_security_group_id      = module.alb.security_group_id
  target_group_arn           = module.alb.blue_target_group_arn
  key_pair_name              = var.key_pair_name
  app_name                   = var.app_name
  docker_image               = var.docker_image
  aws_region                 = var.region
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  
  depends_on = [module.vpc, module.iam, module.alb]
}

module "codedeploy" {
  source = "./modules/codedeploy"
  
  project_name            = var.project_name
  codedeploy_role_arn     = module.iam.codedeploy_role_arn
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
  alb_listener_arn        = module.alb.listener_arn
  blue_target_group_name  = module.alb.blue_target_group_name
  green_target_group_name = module.alb.green_target_group_name
  
  depends_on = [module.iam, module.ecs, module.alb]
}

module "codebuild" {
  source = "./modules/codebuild"
  
  project_name        = var.project_name
  artifact_bucket_arn = module.s3.bucket_arn
  
  depends_on = [module.s3]
}

module "codepipeline" {
  source = "./modules/codepipeline"
  
  project_name                    = var.project_name
  artifact_bucket_name            = module.s3.bucket_name
  artifact_bucket_arn             = module.s3.bucket_arn
  codebuild_project_name          = module.codebuild.project_name
  codebuild_project_arn           = module.codebuild.project_arn
  codedeploy_app_name             = module.codedeploy.app_name
  codedeploy_deployment_group_name = module.codedeploy.deployment_group_name
  codestar_connection_arn         = var.codestar_connection_arn
  github_repo                     = var.github_repo
  github_branch                   = var.github_branch
  
  depends_on = [module.s3, module.codebuild, module.codedeploy]
}