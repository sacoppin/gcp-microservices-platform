module "network" {
  source   = "../../modules/network"
  region   = var.region
}

module "gke" {
  source     = "../../modules/gke"
  region     = var.region
  project_id = var.project_id
  network    = module.network.vpc_name
  subnetwork = module.network.subnet_name
}

provider "google" {
  project = var.project_id
  region  = var.region
}
