# 🚀 GCP Private Zonal GKE Cluster Deployment with Terraform (Windows Guide)

This guide explains how to **set up a Service Account**, **generate a key**, and **deploy a Private Zonal GKE Cluster** on Google Cloud Platform using **Terraform**, specifically for **Windows** users.

---

## 📋 Prerequisites

Before you start:

1. Install [Terraform](https://developer.hashicorp.com/terraform/downloads):

Download the installer from the [Terraform Downloads Page](https://developer.hashicorp.com/terraform/downloads) and follow the Windows installation instructions.

After installation, verify:

```powershell
terraform -v
```

2. Install [Google Cloud SDK for Windows](https://cloud.google.com/sdk/docs/install-sdk):

Download the installer and install normally.  
Then initialize:

```powershell
gcloud init
```

3. Authenticate your gcloud CLI:

```powershell
gcloud auth login
```

4. Ensure you have **Project Owner** or **IAM Admin** access in your GCP project.

---
## 📥 Clone Terraform Repositories
Clone the repository containing both branches.
```
git clone https://github.com/prdp-18/Terraform.git
cd Terraform
```
Then checkout the two branches separately:
```
# For Service Account creation
git checkout ServiceAccount

# OR

# For GKE Cluster deployment
git checkout PrivateGKEwithVPC
```
---

## 🛠 Step-by-Step Process

### 1. Create a Terraform Deployer Service Account
Switch to the ServiceAccount branch:
Open **Command Prompt** 

```
git checkout ServiceAccount
```

Set your GCP Project ID in terraform.tfvars or during plan/apply

```hcl
project_id = "your-gcp-project-id"
```

Initialize and apply Terraform:

```powershell
terraform init
terraform plan
terraform apply
```

✅ This will create a **Service Account** with the required IAM roles.

---

### 2. Manually Create and Download a Service Account Key

After the Service Account is created:

- Go to [GCP Console → IAM & Admin → Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts).
- Find the Service Account **`terraform-deployer`**.
- Click **"Manage Keys" → "Add Key" → "Create new key"**.
- Choose **JSON** format.
- **Download** and **save** the key file securely on your machine (example path: `C:\Users\YourUsername\keys\terraform-deployer-key.json`).

> ⚠️ **Important:** Never upload this JSON key to GitHub or any public repo.

---

### 3. Update the GKE Cluster Terraform Configuration

Switch to the PrivateGKEwithVPC branch:

```powershell
git checkout PrivateGKEwithVPC
```

Edit the `providers.tf` file and **update the credentials path** with double backslashes (`\\`) for Windows:

```hcl
provider "google" {
  credentials = file("C:\\Users\\YourUsername\\keys\\terraform-deployer-key.json")
  project     = var.project_id
  region      = var.region
}
```
(Note: Use double \\ for Windows file paths.)


Update or create a `terraform.tfvars` file:

```hcl
project_id = "your-gcp-project-id"
region     = "us-central1"
```

---

### 4. Deploy the Private Zonal GKE Cluster

Initialize Terraform:

```powershell
terraform init
```

Preview the plan:

```powershell
terraform plan
```

Apply the configuration:

```powershell
terraform apply
```

✅ This will:
- Enable necessary GCP APIs
- Create VPC, Subnets, Cloud NAT
- Create a Private GKE Zonal Cluster
- Deploy a Node Pool

---

## 📤 Output

After successful deployment, Terraform will display:

```powershell
Outputs:

gke_cluster_name = "gke-terra"
```

You can now connect to your Kubernetes cluster using `gcloud` and `kubectl`!

---

## ⚠️ Important Notes

- Service Account keys are **sensitive** — protect them carefully.
- Nodes will have only **internal IPs**, meaning they are private.
- Cloud NAT allows private nodes to access the internet for pulling container images, updates, etc.
- Kubernetes control plane endpoint remains **public** unless further restricted.

---

## 🧹 Cleanup

To destroy the infrastructure:

1. Destroy GKE cluster and related resources:

```powershell
cd path\to\gcp-terraform\gke-cluster-deployment
terraform destroy
```

2. Destroy the Service Account:

```powershell
cd path\to\gcp-terraform\service-account-setup
terraform destroy
```

---

# 🎯 Summary

You have now:
- Created a secure Terraform deployer Service Account
- Downloaded the key manually
- Configured Terraform to authenticate with that Service Account
- Deployed a **Private Zonal GKE Cluster** safely

---
