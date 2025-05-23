# ☁️ Poc Muilti-Cloud AWS, GCP, OCI, Azure

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-green?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![GitHub Actions](https://img.shields.io/badge/github--actions-enabled-blue?logo=github-actions)](https://github.com/actions)
[![Terramate](https://img.shields.io/badge/terramate-enabled-02456C?logo=terramate)](https://terramate.io/)
[![AWS](https://img.shields.io/badge/aws-enabled-orange?logo=amazon)](https://aws.amazon.com/)
[![Google Cloud](https://img.shields.io/badge/google--cloud-enabled-blue?logo=google-cloud)](https://cloud.google.com/)
[![OCI](https://img.shields.io/badge/oci-enabled-red?logo=oracle)](https://www.oracle.com/cloud/)
[![Azure](https://img.shields.io/badge/azure-enabled-blue?logo=microsoft-azure)](https://azure.microsoft.com/)
[![Terraform](https://img.shields.io/badge/terraform-version_1.12.1-3776AB?logo=terraform)](https://www.terraform.io/)
![GitHub](https://img.shields.io/badge/github-enabled-blue?logo=github)
[![Terraform](https://img.shields.io/badge/terraform-enabled-8A4182?logo=terraform)](https://www.terraform.io/)
![licence](https://img.shields.io/badge/license-MIT-blue.svg)


## Descricão da POC


## Estrutura de Diretórios do Projeto

```text.
├── imports
│ └── templates
└── stacks
    └── terraform
        ├── aws
        │ └── envs
        │     ├── dev
        │     │ ├── k8s
        │     │ ├── karpenter
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     ├── prod
        │     │ ├── k8s
        │     │ ├── karpenter
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     └── stg
        │         ├── k8s
        │         ├── karpenter
        │         ├── monitoring
        │         ├── resources
        │         └── vpc
        ├── azure
        │ └── envs
        │     ├── dev
        │     │ ├── k8s
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     ├── prod
        │     │ ├── k8s
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     └── stg
        │         ├── k8s
        │         ├── monitoring
        │         ├── resources
        │         └── vpc
        ├── google
        │ └── envs
        │     ├── dev
        │     │ ├── k8s
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     ├── prod
        │     │ ├── k8s
        │     │ ├── monitoring
        │     │ ├── resources
        │     │ └── vpc
        │     └── stg
        │         ├── k8s
        │         ├── monitoring
        │         ├── resources
        │         └── vpc
        └── oracle
            └── envs
                ├── dev
                │ ├── k8s
                │ ├── monitoring
                │ ├── resources
                │ └── vpc
                ├── prod
                │ ├── k8s
                │ ├── monitoring
                │ ├── resources
                │ └── vpc
                └── stg
                    ├── k8s
                    ├── monitoring
                    ├── resources
                    └── vpc
```