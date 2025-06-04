terraform {
  backend "gcs" {
    bucket  = "boutique-tf-state-${var.project_id}"
    prefix  = "terraform/state"
  }
}