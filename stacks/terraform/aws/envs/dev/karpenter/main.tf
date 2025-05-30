module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.36.0"

  cluster_name                    = module.eks.cluster_name
  irsa_oidc_provider_arn          = module.eks.oidc_provider_arn
  irsa_namespace_service_accounts = var.karpenter_namespace
  queue_name                      = module.eks.cluster_name
  enable_pod_identity             = true
  enable_v1_permissions           = true
  enable_irsa                     = true
  create_instance_profile         = true

  node_iam_role_additional_policies = {
    AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    AmazonSSMManagedInstanceCore       = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
    AmazonEBSCSIDriverPolicy           = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    AmazonEFSCSIDriverPolicy           = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  }

  tags = {
    ManagedBy   = "Terraform"
    Owner       = "Platform Engeneering"
    Environment = "dev"
  }
  depends_on = [
    module.eks
  ]
}

resource "helm_release" "karpenter_crds" {
  namespace        = "karpenter"
  create_namespace = true

  name                = "karpenter-crd"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter-crd"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  version             = "1.5.0"

  depends_on = [
    module.karpenter
  ]
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name                = "karpenter"
  repository          = "oci://public.ecr.aws/karpenter"
  chart               = "karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  version             = "1.5.0"

  values = [
    <<-EOT
    replicas: 1
    serviceAccount:
      name: ${module.karpenter.service_account}
      annotations:
        eks.amazonaws.com/role-arn: ${module.karpenter.iam_role_arn}
    settings:
      clusterName: ${module.eks.cluster_name}
      clusterEndpoint: ${module.eks.cluster_endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
    controller:
      logLevel: info
      resources:
        limits:
          cpu: 1
          memory: 1Gi
        requests:
          cpu: 250m
          memory: 512Mi
    EOT
  ]

  depends_on = [
    helm_release.karpenter_crds
  ]

  lifecycle {
    ignore_changes = [
      repository_password
    ]
  }
}

resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: karpenter
spec:
  role: "${module.karpenter.iam_role_name}"
  amiFamily: AL2023
  amiSelectorTerms:
    - alias: "al2023@latest"
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

resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1
    kind: NodePool
    metadata:
      name: karpenter
    spec:
      template:
        spec:
          requirements:
            - key: "karpenter.k8s.aws/instance-family"
              operator: In
              values: [ "t2", "t3", "t3a","m5"]
            - key: "karpenter.k8s.aws/instance-size"
              operator: In
              values: ["small","medium"]
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

  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]
}