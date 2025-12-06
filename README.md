# terraform-writefreely-hetzner

Deploy a writefreely container on a Hetzner cloud server
using Terraform/OpenTofu.

## Usage


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >= 1.57 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.57.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.web_ingress](https://registry.terraform.io/providers/opentofu/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall_attachment.web_ingress](https://registry.terraform.io/providers/opentofu/hcloud/latest/docs/resources/firewall_attachment) | resource |
| [hcloud_server.this](https://registry.terraform.io/providers/opentofu/hcloud/latest/docs/resources/server) | resource |
| [random_id.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_public_addresses"></a> [public\_addresses](#input\_public\_addresses) | Provision IPv4 and/or IPv6 addresses. (IPv6 is free and IPv4 costs.) | <pre>object({<br>    ipv6 = optional(bool, true)<br>    ipv4 = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_server_backups"></a> [server\_backups](#input\_server\_backups) | Enable automated server backups. (This costs extra.) | `bool` | `true` | no |
| <a name="input_server_deletion_protection"></a> [server\_deletion\_protection](#input\_server\_deletion\_protection) | Prevent server from being deleted or rebuilt in the Hetzner cloud console. NB: deletion via Terraform/OpenTofu is still possible. | `bool` | `false` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | The operating system image to be installed on the server | `string` | `"debian-13"` | no |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | The Hetzner cloud location in which to provision the server. See https://docs.hetzner.com/cloud/general/locations/#what-locations-are-there | `string` | `"fsn1"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | Hetzner server type on which to deploy Writefreely | `string` | `"cx23"` | no |
| <a name="input_writefreely_admin_password"></a> [writefreely\_admin\_password](#input\_writefreely\_admin\_password) | The password of the admin user of the Writefreely instance | `string` | n/a | yes |
| <a name="input_writefreely_admin_username"></a> [writefreely\_admin\_username](#input\_writefreely\_admin\_username) | The username of the admin user of the Writefreely instance | `string` | `"admin"` | no |
| <a name="input_writefreely_hostname"></a> [writefreely\_hostname](#input\_writefreely\_hostname) | The hostname of the Writefreelyblog. e.g. example.com | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall"></a> [firewall](#output\_firewall) | n/a |
| <a name="output_server"></a> [server](#output\_server) | n/a |
