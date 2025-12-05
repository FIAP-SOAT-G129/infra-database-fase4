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
    db_name           = "orders_db"
    username          = var.mongo_username
    password          = var.mongo_password
  }
}

