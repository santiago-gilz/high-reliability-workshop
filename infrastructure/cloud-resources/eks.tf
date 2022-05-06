module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "colombia40-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.5"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_name = "colombia40-eks"
  cluster_version = "1.22"
  cluster_ip_family = "ipv4"
  cluster_service_ipv4_cidr = "10.100.0.0/16"
  cluster_security_group_name = "nodes-sg"
  node_security_group_name = "nodes-sg"
  cluster_iam_role_dns_suffix = ""
  cluster_encryption_policy_name = ""
  cluster_encryption_policy_path = ""

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.xlarge."]

    }
  }
}
