module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-cluster"
  cluster_version = "1.31"

  vpc_id = aws_vpc.main.id

  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1b.id
  ]

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::217428065218:user/merryadmin"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    default = {

      desired_size = 2
      min_size     = 1
      max_size     = 3

      instance_types = ["t3.medium"]

      ami_type = "AL2_x86_64"
    }
  }
}