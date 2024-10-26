module "iam_assumable_role_alb_controller" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.0.0"
  create_role                   = true
  role_name                     = "${local.cluster_name}-alb-controller"
  role_description              = "Used by AWS Load Balancer Controller for EKS"
  provider_url                  = module.eks.cluster_oidc_issuer_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
}

## IAM 정책 변경해야했음
## 예전 정책이라 ALB 타겟 연결 불가
##https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json
data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/refs/heads/main/docs/install/iam_policy.json"
}

# 인라인으로 정책이 추가
resource "aws_iam_role_policy" "controller" {
  name_prefix = "AWSLoadBalancerControllerIAMPolicy"
  policy      = data.http.iam_policy.response_body
  role        = module.iam_assumable_role_alb_controller.iam_role_name
}

