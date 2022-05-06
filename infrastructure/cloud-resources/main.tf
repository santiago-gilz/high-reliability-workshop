terraform {
  required_version = "1.1.9"
  backend "s3" {
    bucket         = "col40tfstate"
    key            = "colombia40.tfstate"
    region         = "us-east-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.13.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

provider "aws" {
  
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}