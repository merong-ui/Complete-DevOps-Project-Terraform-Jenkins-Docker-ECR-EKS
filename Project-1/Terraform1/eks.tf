// This Terraform configuration defines an Amazon EKS (Elastic
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "devops-cluster"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1b.id
  ]


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