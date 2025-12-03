variable "ecr-repos" {
  type = list(string)
  default = [
    "custody-solution-api",
    "custody-super-admin-api",
    "custody-private-server",
    "custody-keys-bridge",
    "custody-solution-corporate-dashboard",
    "custody-super-admin-dashboard",
    "custody-solution-api-dev",
    "custody-super-admin-api-dev",
    "custody-private-server-dev",
    "custody-keys-bridge-dev",
    "custody-solution-api-demo",
    "custody-super-admin-api-demo",
    "custody-private-server-demo",
    "custody-keys-bridge-demo",
    "block-chain-demo",
    "rox-custody-swapping",
    "rox-custody-swapping-dev",
    "rox-custody-swapping-demo",
    "roxchain-indexer-demo",
    "roxchain-indexer-prod",
    "custody-developer-dashboard",
    "custody-policy-manager-dev",
    "custody-policy-manager-demo",
    "custody-policy-manager"
  ]
}

# Create ECR repositories
resource "aws_ecr_repository" "repos" {
  for_each = toset(var.ecr-repos)

  name                 = each.value
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}