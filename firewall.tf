resource "hcloud_firewall" "web_ingress" {
  name = "http-ingress-${random_id.suffix.hex}"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "433"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall_attachment" "web_ingress" {
  firewall_id = hcloud_firewall.web_ingress.id
  server_ids  = [hcloud_server.this.id]
}
