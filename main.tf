module "rds" {
  source             = "./modules/rds"
  name               = var.name
  region             = var.region
  master_username    = var.master_username
  master_password    = var.master_password
  security_group_ids = [module.security_group.id]
  subnet_ids         = data.terraform_remote_state.foundation.outputs.public_subnet_ids

  tags = var.tags
}

module "security_group" {
  source         = "./modules/security-group"
  name           = var.name
  vpc_id         = data.terraform_remote_state.foundation.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.foundation.outputs.vpc_cidr_block

  tags = var.tags
}

module "postgres" {
  source    = "./modules/postgres"
  host      = module.rds.address
  port      = module.rds.port
  databases = var.databases

  depends_on = [
    module.rds,
    module.security_group
  ]
}

module "secrets" {
  source             = "./modules/secrets-manager"
  name               = var.name
  db_host            = module.rds.address
  db_port            = module.rds.port
  db_master_username = var.master_username
  db_master_password = var.master_password
  databases          = var.databases

  depends_on = [module.rds]
}
