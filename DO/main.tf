terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://fra1.digitaloceanspaces.com"
    }

    bucket = "pepestein-tfstate"
    key    = "stage/stage.tfstate"

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    region                      = "us-east-1"
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_vpc" "network" {
  name     = "network"
  region   = "fra1"
  ip_range = var.ip_range
}

resource "digitalocean_tag" "stage" {
  name = "stage"
}

resource "digitalocean_tag" "prod" {
  name = "prod"
}

# resource "digitalocean_tag" "test" {
#   name = "test"
# }
