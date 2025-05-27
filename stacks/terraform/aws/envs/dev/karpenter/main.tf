module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.36.0"

  cluster_name                    = var.cluster_name
  enable_v1_permissions           = true
  enable_pod_identity             = true
  # create_pod_identity_association = true

  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  tags = {
    Owner       = "Platform Engineering"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "helm_release" "karpenter" {
  namespace  = "kube-system"
  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  # repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  # repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart   = "karpenter"
  version = "1.5.0"
  wait    = false

  values = [
    <<-EOT
    serviceAccount:
      name: ${module.karpenter.service_account}
    settings:
      clusterName: ${var.cluster_name}
      clusterEndpoint: ${data.terraform_remote_state.eks.outputs.cluster_endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
    EOT
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
      name: default
    spec:
      detailedMonitoring: true
      role: ${module.karpenter.node_iam_role_name}
      amiFamily: AL2023
      amiSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.cluster_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.cluster_name}
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${var.cluster_name}
      tags:
        karpenter.sh/discovery: ${var.cluster_name}
    blockDeviceMappings:
      - deviceName: /dev/xvda
        ebs:
          volumeType: gp3
          volumeSize: 20Gi
          deleteOnTermination: true
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
      name: default
    spec:
      template:
        spec:
          nodeClassRef:
            group: karpenter.k8s.aws
            kind: EC2NodeClass
            name: default
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["t"]
            - key: "karpenter.k8s.aws/instance-family"
              operator: In
              values: ["t3","t3a","t4g"]
            - key: "karpenter.k8s.aws/instance-size"
              operator: NotIn
              values: ["nano", "micro", "small"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["2"]
            - key: "karpenter.k8s.aws/instance-hypervisor"
              operator: In
              values: ["nitro"]
            - key: "karpenter.k8s.aws/instance-generation"
              operator: Gt
              values: ["2"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["on-demand"]
      limits:
        cpu: 1000
      disruption:
        consolidationPolicy: WhenEmpty
        consolidateAfter: 30s
  YAML

  depends_on = [
    kubectl_manifest.karpenter_node_class
  ]
}