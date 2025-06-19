terraform {
  backend "gcs" {
    bucket = "infrateam-playground-tf-state"
    prefix = "terraform-training-duc-bac/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
