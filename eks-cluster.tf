provider "kubernetes" {
  provider "kubernetes" {
    load_config_file       = false
    host                   = data.aws_eks_cluster.rox-eks-cluster.endpoint
    token                  = data.aws_eks_cluster_auth.rox-eks-cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.rox-eks-cluster.certificate_authority[0].data)

    depends_on = [module.eks]
  }

}

data "aws_eks_cluster" "rox-eks-cluster" {
  name = module.eks.cluster_name

  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "rox-eks-cluster" {
  name = module.eks.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.35.0"

  cluster_name                   = "rox-eks-cluster"
  cluster_version                = "1.32"
  cluster_endpoint_public_access = true
  subnet_ids                     = module.vpc.private_subnets
  vpc_id                         = module.vpc.vpc_id
  cluster_addons = {
    vpc-cni = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
    coredns = {
      most_recent       = true
      resolve_conflicts = "OVERWRITE"
    }
  }
  eks_managed_node_groups = {
    app = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["r5.large"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      update_config = {
        max_unavailable = 1
      }
      kubernetes_version = "1.32"
    }
    efk-nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["r5.large"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      labels = {
        nodegroup-type = "efk-group"
      }
      taints = [{
        key    = "efk-key"
        value  = "true"
        effect = "NO_SCHEDULE"
      }]
      update_config = {
        max_unavailable = 1
      }
      kubernetes_version = "1.32"
    }
  }

  tags = {
    environment = "production"
  }
}