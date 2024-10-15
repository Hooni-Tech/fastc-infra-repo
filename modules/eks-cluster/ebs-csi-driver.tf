## CSI(Container Storage Interface)
## kubecost 구성간에 CSI 드라이버 필요
module "ebs-csi-driver" {
  source   = "DrFaust92/ebs-csi-driver/kubernetes"
  version  = "3.5.0"
  oidc_url = module.eks.oidc_provider
}
