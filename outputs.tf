output "server" {
  value = hcloud_server.this
}

output "firewall" {
  value = hcloud_firewall.web_ingress
}
