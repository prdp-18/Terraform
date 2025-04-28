locals {
  apis = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "vpcaccess.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]
}

resource "google_project_service" "enable_apis" {
  for_each = toset(local.apis)

  project = var.project_id
  service = each.value
  disable_on_destroy = false
}