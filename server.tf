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
#cloud-config
package_update: true
package_upgrade: true
packages:
  - ca-certificates
  - curl
  - software-properties-common
write_files:
  - path: /etc/opt/writefreely/docker-compose.yaml
    content: |
      services:
        writefreely:
          image: algernon/writefreely
          hostname: writefreely
          network_mode: host
          volumes:
            - wf_data:/data
          env_file: .env
          restart: unless-stopped
        caddy:
          image: caddy
          network_mode: host
          volumes:
            - ./Caddyfile:/etc/caddy/Caddyfile
            - caddy_ssl_data:/data
      volumes:
        wf_data:
        caddy_ssl_data:

  - path: /etc/opt/writefreely/Caddyfile
    content: |
      ${var.writefreely_hostname}

      reverse_proxy localhost:8080

  - path: /etc/opt/writefreely/.env
    content: |
      WRITEFREELY_HOST="https://${var.writefreely_hostname}"
      WRITEFREELY_SINGLE_USER=true
      WRITEFREELY_ADMIN_USER="${var.writefreely_admin_username}"
      WRITEFREELY_ADMIN_PASSWORD="${var.writefreely_admin_password}"

  - path: /etc/apt/sources.list.d/docker.sources
    content: |
      Types: deb
      URIs: https://download.docker.com/linux/debian
      Suites: VERSION_CODENAME_PLACEHOLDER
      Components: stable
      Signed-By: /etc/apt/keyrings/docker.asc
    permissions: "0644"
    owner: root:root
runcmd:
  - sed -i -e "s/VERSION_CODENAME_PLACEHOLDER/$(. /etc/os-release && echo "$VERSION_CODENAME")/g" /etc/apt/sources.list.d/docker.sources
  - install -m 0755 -d /etc/apt/keyrings
  - curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  - chmod a+r /etc/apt/keyrings/docker.asc
  - DEBIAN_FRONTEND=noninteractive apt-get -y update
  - DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  - systemctl enable docker
  - cd /etc/opt/writefreely && docker compose up -d
EOT
}
