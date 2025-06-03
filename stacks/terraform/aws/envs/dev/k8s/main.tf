module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  enable_cluster_creator_admin_permissions = var.creator_admin_permissions
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  enable_irsa                              = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  cluster_enabled_log_types                = var.cluster_enabled_log_types

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.intra_subnets

  cluster_addons = {
    coredns = {
      most_recent_version = true
    }
    eks-pod-identity-agent = {
      most_recent_version = true
    }
    kube-proxy = {
      most_recent_version = true
    }
    vpc-cni = {
      most_recent_version = true
    }
    aws-ebs-csi-driver = {
      most_recent_version = true
    }
    aws-efs-csi-driver = {
      most_recent_version = true
    }
  }
  eks_managed_node_groups = {
    default = {
      ami_type       = var.ami_type
      instance_types = var.instance_types
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size

    }

  }
  iam_role_additional_policies = {
    AmazonEBSCSIDriverPolicy  = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  tags = local.tags
}

resource "kubectl_manifest" "ebs-sc" {
  yaml_body = <<-YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: ebs-sc
      annotations:
        storageclass.kubernetes.io/is-default-class: "true"
    provisioner: ebs.csi.aws.com
    reclaimPolicy: Delete
    volumeBindingMode: WaitForFirstConsumer
  YAML

}

resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "ClusterAutoscalerPolicy"
  description = "IAM policy for the Cluster Autoscaler to manage EKS nodes"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ],
        Resource = "*"
      }
    ]
  })
}

module "cluster_autoscaler_sa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.55.0"

  create_role      = true
  role_name        = "${module.eks.cluster_name}-cluster-autoscaler"
  provider_url     = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns = [aws_iam_policy.cluster_autoscaler.arn]
  oidc_fully_qualified_subjects = [
    "system:serviceaccount:kube-system:cluster-autoscaler"
  ]
  depends_on = [
    module.eks
  ]
  tags = local.tags
}

resource "kubernetes_service_account" "cluster_autoscaler" {
  metadata {
    name      = "cluster-autoscaler"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.cluster_autoscaler_sa.iam_role_arn
    }
  }
  depends_on = [
    module.cluster_autoscaler_sa
  ]
}


resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.46.6"

  values = [
    <<-EOT
    autoDiscovery:
      clusterName: ${var.cluster_name}
    awsRegion: ${var.region}
    rbac:
      serviceAccount:
        create: false
        name: ${kubernetes_service_account.cluster_autoscaler.metadata[0].name}
    extraArgs:
      balance-similar-node-groups: "true"
      skip-nodes-with-system-pods: "false"
      skip-nodes-with-local-storage: "false"
    EOT
  ]

  depends_on = [
    kubernetes_service_account.cluster_autoscaler
  ]
}

