module "rds" {
  source             = "./modules/rds"
  name               = var.name
  region             = var.region
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  security_group_ids = [module.security_group.id]
  subnet_ids         = data.terraform_remote_state.foundation.outputs.private_subnet_ids
  tags               = var.tags
}

module "security_group" {
  source         = "./modules/security-group"
  name           = var.name
  vpc_id         = data.terraform_remote_state.foundation.outputs.vpc_id
  vpc_cidr_block = data.terraform_remote_state.foundation.outputs.vpc_cidr_block
  tags           = var.tags
}

module "secrets" {
  source      = "./modules/secrets-manager"
  name        = var.name
  db_name     = var.db_name
  db_host     = module.rds.address
  db_port     = module.rds.port
  db_username = var.db_username
  db_password = var.db_password

  depends_on = [module.rds]
}
