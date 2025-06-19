terraform {
  backend "gcs" {
    bucket = "infrateam-playground-tf-state"
    prefix = "terraform-training-bacdd/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region

}
