# 🚀 GKE Private Cluster on GCP with Terraform

This project uses Terraform to deploy a **private** GKE (Google Kubernetes Engine) cluster on GCP with the following infrastructure:

- Enable required APIs
- Create custom VPC and Subnet
- Configure Cloud Router and Cloud NAT
- Create GKE Node Service Account with IAM roles
- Deploy private GKE cluster
- Create a managed Node Pool

---

## 📋 Table of Contents

- [Project Structure](#project-structure)
- [Steps Explained](#steps-explained)
- [Variables](#variables)
- [How to Use](#how-to-use)
- [Output](#output)

---

## 📁 Project Structure

| File           | Purpose |
|----------------|---------|
| `apis.tf`       | Enable required GCP APIs |
| `providers.tf`  | Configure the GCP provider |
| `main.tf`       | Create network, NAT, GKE cluster, and node pool |
| `variables.tf`  | Define input variables |
| `outputs.tf`    | Output cluster information |

---

## 🔥 Steps Explained

### 1. Enable Required APIs
**File:** `apis.tf`

Enables essential Google APIs such as:
- Kubernetes Engine API
- Compute Engine API
- IAM API
- VPC Access API
- Cloud Resource Manager API

---

### 2. Configure the GCP Provider
**File:** `providers.tf`

Sets up the Terraform provider to interact with GCP by specifying:
- Project ID
- Region and zone
- Service account credentials file

---

### 3. Create VPC Network and Subnetwork
**File:** `main.tf`

- Custom VPC (`vpc-terra`) with no auto-created subnets.
- Custom Subnet (`terra-subnet`) with:
  - Primary IP range for nodes
  - Secondary IP ranges for GKE Pods and Services.

---

### 4. Set Up Cloud NAT for Internet Access
- Creates a **Cloud Router** (`gke-router`).
- Creates a **Cloud NAT** (`gke-nat`) attached to the router.
- Allows private GKE nodes to access the internet (for updates, pulling images) **without** exposing public IPs.

---

### 5. Create GKE Node Service Account and IAM Roles
- Creates a service account `gke-node-sa`.
- Binds necessary roles for:
  - Logging (`roles/logging.logWriter`)
  - Monitoring (`roles/monitoring.metricWriter`)
  - Node operations (`roles/container.nodeServiceAccount`)

---

### 6. Deploy a Private GKE Cluster
- Creates a **private GKE cluster** named `gke-terra`.
- Only internal IPs are assigned to nodes.
- Private endpoint is disabled (public control plane endpoint is used for cluster management).
- Uses custom IP ranges for pods and services.
- No default node pool is created.

---

### 7. Create GKE Node Pool
- Creates a managed node pool (`internal-pool`) with:
  - Machine type: `e2-standard-4`
  - Attached service account
  - Metadata server hardened (legacy endpoints disabled)
  - Node autoscaling between 1–3 nodes
  - Auto-repair and auto-upgrade enabled

---

## ⚙️ Variables

| Variable     | Description                  | Default |
|--------------|------------------------------|---------|
| `project_id` | GCP project ID                 | — |
| `region`     | Default region for resources   | `us-central1` |

---

## 🚀 How to Use

1. **Set up your service account:**
   - Create a GCP service account with permissions to manage GKE and networking.
   - Download its JSON key file.

2. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

3. **Update the `providers.tf` file:**
   - Set the correct path to your service account key JSON.

4. **Initialize Terraform:**
   ```bash
   terraform init
   ```

5. **Plan your infrastructure:**
   ```bash
   terraform plan 
   ```

6. **Apply the configuration:**
   ```bash
   terraform apply 
   ```

---

## 📤 Output

After successful deployment, Terraform will output:
- The name of the created GKE cluster.

Example:
```bash
Outputs:

gke_cluster_name = "gke-terra"
```

---
