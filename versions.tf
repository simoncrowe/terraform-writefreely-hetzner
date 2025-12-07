terraform {
  required_providers {
    hcloud = {
      source  = "opentofu/hcloud"
      version = ">= 1.57"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.2.7"
    }
  }
}
