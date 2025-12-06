resource "hcloud_server" "this" {
  name        = "writefreely-${random_id.suffix.hex}"
  server_type = var.server_type
  image       = var.server_image
  location    = var.server_location

  backups            = var.server_backups
  delete_protection  = var.server_deletion_protection
  rebuild_protection = var.server_deletion_protection

  public_net {
    ipv6_enabled = var.public_addresses.ipv6
    ipv4_enabled = var.public_addresses.ipv4
  }

  user_data = <<EOT

  EOT
}
