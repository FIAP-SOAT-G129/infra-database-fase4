module "rds" {
  source             = "./modules/rds"
  name               = var.name
  region             = var.region
  databases          = var.databases
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

module "secrets" {
  source              = "./modules/secrets-manager"
  name                = var.name
  connections_details = local.connections_details

  depends_on = [module.rds]
}
