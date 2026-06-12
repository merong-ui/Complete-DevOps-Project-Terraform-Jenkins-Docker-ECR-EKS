module "eks" {

  source = "terraform-aws-modules/eks/aws"

  cluster_name = "devops-cluster"

  cluster_version = "1.33"

  eks_managed_node_groups = {

    default = {

      desired_size = 2
      min_size     = 2
      max_size     = 4

      instance_types = ["t3.medium"]

    }

  }

}