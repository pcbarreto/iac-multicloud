module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  enable_cluster_creator_admin_permissions = var.creator_admin_permissions
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  authentication_mode                      = "API"
  enable_irsa                              = true

  cluster_addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {}
    aws-ebs-csi-driver = {}
    aws-efs-csi-driver = {}
  }

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.intra_subnets

  eks_managed_node_groups = {
    karpenter = {
      ami_type       = var.ami_type
      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      labels = {
        # Used to ensure Karpenter runs on nodes that it does not manage
        "karpenter.sh/controller" = "true"
      }

      taints = {
        addons = {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        },
      }
    }
  }

  node_security_group_tags = {
    "karpenter.sh/discovery" = var.cluster_name
  }

  tags = {
    ManagedBy   = "Terraform"
    Owner       = "Platform Engeneering"
    Environment = "dev"
  }
}

module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.36.0"

  cluster_name          = module.eks.cluster_name
  enable_v1_permissions = true
  enable_pod_identity   = true
  enable_irsa           = true

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = {
    ManagedBy   = "Terraform"
    Owner       = "Platform Engeneering"
    Environment = "dev"
  }
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true
  name             = "karpenter"
  repository       = "oci://public.ecr.aws/karpenter"
  chart   = "karpenter"
  version = "1.5.0"
  wait    = true

  set {
    name  = "settings.clusterName"
    value = module.eks.cluster_name
  }
  set {
    name  = "settings.clusterEndpoint"
    value = module.eks.cluster_endpoint
  }
  set {
    name  = "settings.interruptionQueue"
    value = module.karpenter.queue_name
  }

  depends_on = [
    module.karpenter
  ]
}

resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1
    kind: EC2NodeClass
    metadata:
      name: karpenter-default
    spec:
      role: "${module.karpenter.iam_role_name}"
      amiFamily: Bottlerocket
      amiSelectorTerms:
        - alias: "bottlerocket@latest"
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${module.eks.cluster_name}"
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: "${module.eks.cluster_name}"
      blockDeviceMappings:
        - deviceName: /dev/xvda
          ebs:
            volumeType: gp3
            volumeSize: 20Gi
            encrypted: true
            deleteOnTermination: true
      detailedMonitoring: true
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

# instanceProfile: "${module.karpenter.instance_profile_name}"

resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1
    kind: NodePool
    metadata:
      name: karpenter-default
    spec:
      template:
        spec:
          requirements:
            - key: "karpenter.k8s.aws/instance-family"
              operator: In
              values: [ "t2", "t3", "t3a", "t4g"]
            - key: "karpenter.k8s.aws/instance-size"
              operator: In
              values: ["micro","small","medium"]
            - key: kubernetes.io/os
              operator: In
              values: ["linux"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["1","2","4","8"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["on-demand"]
          nodeClassRef:
            group: karpenter.k8s.aws
            kind: EC2NodeClass
            name: karpenter-default
          expireAfter: 720h # 30 * 24h = 720h
      limits:
        cpu: 1000
        memory: 1000Gi
      disruption:
        consolidationPolicy: WhenEmptyOrUnderutilized
        consolidateAfter: 1m
  YAML

}