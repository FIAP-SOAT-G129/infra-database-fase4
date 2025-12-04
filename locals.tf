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
}
