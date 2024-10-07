module "eks" {
  # eks 모듈에서 사용할 변수 정의
  source          = "./modules/eks-cluster"
  cluster_name    = "fast-cluster"
  cluster_version = "1.24"
  vpc_id          = "vpc-099d6895a13c1267a"

  private_subnets = ["subnet-02df46384de0e7dfd", "subnet-00145a5ededada888"]
  public_subnets  = ["subnet-042c31a7414f8e3d4", "subnet-002b2805098796dbc"]
}


