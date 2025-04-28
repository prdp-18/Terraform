# Terraform GCP Service Account Setup

This Terraform configuration creates a **Service Account** in Google Cloud Platform (GCP) and assigns it the minimal set of IAM roles required for infrastructure deployment tasks like networking, GKE cluster management, and service usage.

## Resources Created

- A **Service Account**:  
  - `terraform-deployer` (Display Name: "Terraform GCP Deployer Service Account")
- IAM Role Bindings:  
  - `roles/serviceusage.serviceUsageAdmin`
  - `roles/compute.networkAdmin`
  - `roles/container.clusterAdmin`
  - `roles/iam.serviceAccountUser`
  - `roles/iam.serviceAccountCreator`
  - `roles/resourcemanager.projectIamAdmin`

---

## Usage

### 1. Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- Access to a GCP project with permissions to create Service Accounts and assign IAM roles
- Google Cloud SDK (`gcloud`) installed and authenticated

### 2. Initialize and Apply

Clone the repository (or copy the files):

```bash
git clone <repository-url>
cd <repository-folder>
```

Update `terraform.tfvars` or set the `project_id` variable:

```hcl
project_id = "your-gcp-project-id"
```

Then run:

```bash
terraform init
terraform apply
```

Approve the plan when prompted.

---

## Files

- `main.tf` — Defines the Service Account and IAM bindings
- `providers.tf` — Configures the Google provider
- `variables.tf` — Defines input variables

---

## Important Notes

- The created Service Account will have broad permissions like `Project IAM Admin`. You may want to restrict these based on your security requirements.
- Make sure to secure and properly manage any credentials (keys) if you generate keys for this Service Account later.

---

## Cleanup

To delete all resources created by this Terraform configuration:

```bash
terraform destroy
```

---

## License

This project is licensed under the MIT License.
