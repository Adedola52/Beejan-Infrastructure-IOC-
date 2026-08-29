module "iam" {
    source = "./modules/iam/"

    user            = var.user
    group           = var.group
    user_policy     = var.user_policy
    group_policy    = var.group_policy
    role            = var.role
    policy          = var.policy
    role_attachment = var.role_attachment
}

module "storage" {
  source = "./modules/storage"

  s3_bucket     = var.s3_bucket
  glue_database = var.glue_database
  crawler       = var.crawler
  athena        = var.athena
  s3_bucket_versioning = var.s3_bucket_versioning

  glue_role = module.iam.role_arns
}

module "network" {
  source = "./modules/network"

  vpc                     = var.vpc
  subnet                  = var.subnet
  igw                     = var.igw
  route                   = var.route
  route_table             = var.route_table
  route_table_association = var.route_table_association
  security_group          = var.security_group
}

module "compute" {
  source = "./modules/compute"

  instance              = var.instance
  instance_profile      = var.instance_profile
  ecs_cluster           = var.ecs_cluster
  ecs_task_definition   = var.ecs_task_definition

  subnet_ids            = module.network.subnet_ids
  security_group_ids    = module.network.security_group_ids

  role_names            = module.iam.role_names
  role_arns             = module.iam.role_arns
}

module "database" {
  source = "./modules/databases"

  subnet_group = var.subnet_group
  rds          = var.rds

  subnet_ids         = module.network.subnet_ids
  security_group_ids = module.network.security_group_ids
}