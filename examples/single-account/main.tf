#-------------------------------------
# general resources
#-------------------------------------
module "resource_group" {
  source = "../../modules/infrastructure/resource-group"

  name = var.name
  tags = var.tags
}

module "ssm" {
  source                  = "../../modules/infrastructure/ssm"
  name                    = var.name
  sysdig_secure_api_token = data.sysdig_secure_connection.current.secure_api_token
  tags                    = var.tags
}

#
# cspm
#

module "cspm-single-account" {
  source = "../../modules/services/cspm"
  count  = var.deploy_cspm ? 1 : 0

  name              = "${var.name}-cspm"
  tags = var.tags
}

#
# threat-detection
#

module "cloud_connector" {
  count = var.deploy_cloud_connector ? 1 : 0
  source = "../../modules/services/cloud-connector-ecs"
  name   = "${var.name}-cloudconnector"

  secure_api_token_secret_name = module.ssm.secure_api_token_secret_name
  // maybe need to add ecs scanning
  // we are removing ecr scanning from here talk to evan

  is_organizational = false

  build_project_arn  = "na"
  build_project_name = "na"

  existing_cloudtrail_config = {
    cloudtrail_sns_arn = local.cloudtrail_sns_arn
  }


  ecs_cluster_name            = local.ecs_cluster_name
  ecs_vpc_id                  = local.ecs_vpc_id
  ecs_vpc_subnets_private_ids = local.ecs_vpc_subnets_private_ids
  ecs_task_cpu                = var.ecs_task_cpu
  ecs_task_memory             = var.ecs_task_memory

  tags       = var.tags
  depends_on = [local.cloudtrail_sns_arn, module.ssm]
}
