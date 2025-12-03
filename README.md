# 🛠️ Application Infrastructure Setup

This project defines the infrastructure for deploying and managing applications using **Terraform** with **AWS** and **Kubernetes** modules.

---

## 🚀 Technologies Used

- [Terraform AWS Modules](https://registry.terraform.io/namespaces/terraform-aws-modules)
- [Terraform Kubernetes Modules](https://registry.terraform.io/namespaces/terraform-aws-modules/providers/kubernetes)

---

## 📁 Infrastructure Files

### [`vpc.tf`](./vpc.tf)
Defines the following:
- VPC and its CIDR blocks
- Availability Zones
- Public and private subnets
- NAT gateways

---

### [`eks-cluster.tf`](./eks-cluster.tf)
Sets up the EKS cluster and includes:
- Cluster authentication tokens
- Cluster certificate
- Cluster host
- Three worker node groups, each with taints and tolerations:
  - **Node Group 1**: For `privateserver` and `keysbridge`
  - **Node Group 2**: For `efklogs`
  - **Node Group 3**: For all remaining applications

---

### [`rds.tf`](./rds.tf)
Manages:
- Three RDS instances
- Subnet groups and security groups using the VPC module

---

### [`ecr.tf`](./ecr.tf)
Creates an ECR cluster that:
- Hosts repositories containing container images for our applications

---

### [`backend.tf`](./backend.tf)
Ensures:
- Terraform state files are stored in an S3 bucket on AWS
- State is preserved across multiple runs and accessible to team members

---

## 🔗 Quick Links to Terraform Files

- [vpc.tf](./vpc.tf)
- [eks-cluster.tf](./eks-cluster.tf)
- [rds.tf](./rds.tf)
- [ecr.tf](./ecr.tf)
- [backend.tf](./backend.tf)

---

## 📌 Notes

- Be sure to configure your AWS credentials and Terraform backend before running `terraform init`.
- Follow best practices with separate workspaces and state locking if working in a team.

---

