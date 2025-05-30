module "eks_aws_auth" {
  source  = "terraform-aws-modules/eks/aws//modules/aws-auth"
  version = "20.36.0"

  manage_aws_auth_configmap = true

  aws_auth_roles = concat(
    # Karpenter node role
    [
      {
        rolearn  = module.karpenter.node_iam_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ],
    # Add any EKS managed node group roles
    [
      for key, group in module.eks.eks_managed_node_groups : {
        rolearn  = group.iam_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ]
  )

  # Terraform user for cluster administration
  aws_auth_users = [
    {
      userarn  = data.aws_caller_identity.current.arn
      username = "cloud_user"
      groups   = ["system:masters"]
    }
  ]

  depends_on = [
    module.eks,
    module.karpenter
  ]
}

resource "aws_iam_role_policy" "karpenter_passrole" {
  name = "karpenter-passrole"
  role = module.karpenter.node_iam_role_name # este output existe no módulo!

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "iam:PassRole"
        Resource = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/KarpenterController-*"
      }
    ]
  })
  depends_on = [
    module.eks,
    module.karpenter
  ]
}
