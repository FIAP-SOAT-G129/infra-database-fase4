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

module "mongo" {
  source       = "./modules/mongo"
  org_id       = data.mongodbatlas_roles_org_id.fastfood.org_id
  project_name = "${var.name}-orders-project"
  cluster_name = "${var.name}-orders-cluster"
  db_name      = "orders_db"
  username     = var.mongo_username
  password     = var.mongo_password
  cidr_block   = data.terraform_remote_state.foundation.outputs.nat_public_ip
}

module "secrets" {
  source                   = "./modules/secrets-manager"
  name                     = var.name
  connections_details      = local.connections_details
  mongo_connection_details = local.mongo_connection_details

  depends_on = [module.mongo]
}
