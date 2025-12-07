variable "server_type" {
  description = "Hetzner server type on which to deploy Writefreely"
  type        = string
  default     = "cx23"
}

variable "server_image" {
  description = "The operating system image to be installed on the server"
  type        = string
  default     = "debian-13"
}

variable "server_location" {
  description = "The Hetzner cloud location in which to provision the server. See https://docs.hetzner.com/cloud/general/locations/#what-locations-are-there"
  type        = string
  default     = "fsn1"
}

variable "server_backups" {
  description = "Enable automated server backups. (This costs extra.)"
  type        = bool
  default     = true
}

variable "server_deletion_protection" {
  description = "Prevent server from being deleted or rebuilt in the Hetzner cloud console. NB: deletion via Terraform/OpenTofu is still possible."
  type        = bool
  default     = false
}

variable "public_addresses" {
  description = "Provision IPv4 and/or IPv6 addresses. (IPv6 is free and IPv4 costs.)"
  type = object({
    ipv6 = optional(bool, true)
    ipv4 = optional(bool, false)
  })
  default = {}
  validation {
    condition     = var.public_addresses.ipv6 || var.public_addresses.ipv4
    error_message = "At least one of ipv4 and ipv6 must be enabled so your server is reachable via the internet"
  }
}

variable "writefreely_hostname" {
  description = "The hostname of the Writefreelyblog. e.g. example.com"
  type = string
}

variable "writefreely_admin_username" {
  description = "The username of the admin user of the Writefreely instance"
  type = string
  default = "admin"
}

variable "writefreely_admin_password" {
  description = "The password of the admin user of the Writefreely instance"
  type = string
  sensitive = true
}
