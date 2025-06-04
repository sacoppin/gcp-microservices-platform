output "vpc_name" {
  description = "Nom du VPC principal"
  value       = google_compute_network.vpc.name
}

output "subnet_name" {
  description = "Nom du sous-réseau GKE"
  value       = google_compute_subnetwork.gke_subnet.name
}
