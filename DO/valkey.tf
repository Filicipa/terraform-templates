resource "digitalocean_database_cluster" "valkey" {
  name       = "valkey"
  engine     = "valkey"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_firewall" "valkey" {
  cluster_id = digitalocean_database_cluster.valkey.id

  # rule {
  #   type  = "ip_addr"
  #   value = "10.114.0.0/20"
  # }
  rule {
    type  = "droplet"
    value = digitalocean_droplet.backend.id
  }
}
