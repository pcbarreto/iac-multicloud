<!-- BEGIN_TF_DOCS -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_type"></a> [ami\_type](#input\_ami\_type) | The type of the AMI to use for the instances. | `string` | `"BOTTLEROCKET_x86_64"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | List of enabled log types for the cluster | `list(string)` | <pre>[<br/>  "api",<br/>  "audit",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Endpoint public endpoint public access enabled | `bool` | `true` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | `"cluster-dev"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of Kubernetes to install the cluster | `string` | `"1.33"` | no |
| <a name="input_creator_admin_permissions"></a> [creator\_admin\_permissions](#input\_creator\_admin\_permissions) | Role ARN to use for administrator created on the cluster | `bool` | `true` | no |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of nodes for the cluster. | `number` | `2` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Worker instance types for worker nodes | `list(string)` | <pre>[<br/>  "m5.large"<br/>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Maximum number of nodes for the cluster. | `number` | `7` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Minimum number of nodes for the cluster. | `number` | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | The base64 encoded certificate data required to communicate with the EKS cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for the EKS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
<!-- END_TF_DOCS -->