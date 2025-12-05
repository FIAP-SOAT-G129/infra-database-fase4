
resource "mongodbatlas_project" "this" {
  name   = var.project_name
  org_id = var.org_id
}

resource "mongodbatlas_project_ip_access_list" "nat" {
  project_id = mongodbatlas_project.this.id
  cidr_block = var.cidr_block
  comment    = "NAT Gateway IP for Fastfood environment"
}

resource "mongodbatlas_advanced_cluster" "free_cluster" {
  project_id   = mongodbatlas_project.this.id
  name         = var.cluster_name
  cluster_type = "REPLICASET"

  replication_specs = [
    {
      region_configs = [
        {
          electable_specs = {
            instance_size = "M0"
          }
          provider_name         = "TENANT"
          backing_provider_name = "AWS"
          region_name           = var.region
          priority              = 7
        }
      ]
    }
  ]
}

resource "mongodbatlas_database_user" "db_user" {
  username           = var.username
  password           = var.password
  project_id         = mongodbatlas_project.this.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.db_name
  }

  scopes {
    name = var.cluster_name
    type = "CLUSTER"
  }
}


