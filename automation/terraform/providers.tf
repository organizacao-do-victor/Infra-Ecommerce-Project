provider "aws" {
  region = var.REGION
}

terraform {
  cloud {
    organization = "80400815"
    workspaces {name = "Infra-Ecommerce-Project"}
  }
}