resource "google_container_cluster" "primary" {
  name               = "boutique-cluster"
  location           = var.region
  initial_node_count = 1
  network            = var.network
  subnetwork         = var.subnetwork

  deletion_protection = false

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false 
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  node_config {
    disk_size_gb = 50        
    disk_type    = "pd-standard" 
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "spot" {
  name       = "spot-node-pool"
  cluster    = google_container_cluster.primary.id
  location   = var.region
  node_count = 1

  node_config {
    disk_size_gb = 50      
    disk_type    = "pd-ssd"  
    machine_type = "e2-medium"
    spot         = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
