resource "digitalocean_database_cluster" "postgres" {
  name       = "postgres"
  engine     = "pg"
  version    = "17"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  tags       = [digitalocean_tag.prod.name]
}

resource "digitalocean_database_firewall" "postgres" {
  cluster_id = digitalocean_database_cluster.postgres.id

  # rule {
  #   type  = "ip_addr"
  #   value = "10.114.0.0/20"
  # }
  rule {
    type  = "droplet"
    value = digitalocean_droplet.backend.id
  }
}
