# 1. Create Service Account
resource "google_service_account" "terraform_sa" {
  account_id   = "terraform-deployer"
  display_name = "Terraform GCP Deployer Service Account"
}

# 2. Assign Minimal Required Roles
resource "google_project_iam_member" "api_serviceusage_admin" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_project_iam_member" "compute_network_admin" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_project_iam_member" "gke_cluster_admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}


resource "google_project_iam_member" "iam_serviceaccount_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}


resource "google_project_iam_member" "iam_serviceaccount_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountCreator"  
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_project_iam_member" "project_iam_admin" {
  project = var.project_id
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}
