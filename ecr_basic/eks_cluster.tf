variable region {}
variable eks_cluster_name {}

module "eks-cluster-with-ecr" {
  #source           = "github.com/darkn3rd/eks-basic?ref=v0.0.2"
  source = "../eks-basic"
  region           = var.region
  eks_cluster_name = var.eks_cluster_name

  workers_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  ]
}
