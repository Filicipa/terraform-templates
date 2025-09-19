resource "digitalocean_droplet" "backend" {
  # image    = "ubuntu-24-10-x64"
  image    = "119537555"
  name     = "stage"
  region   = "fra1"
  size     = "s-2vcpu-2gb"
  ssh_keys = ["44:32:19:71:ac:49:c2:c7:c8:45:e7:bd:46:a5:6e:8a"]
  backups  = false
  vpc_uuid = digitalocean_vpc.network.id
  # backup_policy {
  #   plan    = "weekly"
  #   weekday = "TUE"
  #   hour    = 8
  # }
  tags      = [digitalocean_tag.stage.name]
  user_data = file("docker.sh")
  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "digitalocean_firewall" "backend" {
  name        = "backend"
  droplet_ids = [digitalocean_droplet.backend.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    source_addresses = [var.ip_range]
  }
  inbound_rule {
    protocol         = "udp"
    port_range       = "all"
    source_addresses = [var.ip_range]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "backend-IP-server" {
  value = digitalocean_droplet.backend.ipv4_address
}
