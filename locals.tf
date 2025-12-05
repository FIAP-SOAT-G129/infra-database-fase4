locals {
  connections_details = {
    for name, creds in var.databases :
    name => merge(
      creds,
      {
        host    = lookup(module.rds.addresses, name, null)
        port    = lookup(module.rds.ports, name, null)
        db_name = lookup(module.rds.db_names, name, null)
      }
    )
  }

  mongo_connection_details = {
    connection_string = module.mongo.connection_string
    db_name           = var.mongo_db_name
    username          = var.mongo_username
    password          = var.mongo_password
  }

  nat_cidr_block = "${data.terraform_remote_state.foundation.outputs.nat_public_ip}/32"
}

