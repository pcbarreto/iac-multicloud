script "init" {
  name        = "Terraform Init"
  description = "Download the required provider plugins and modules and set up the backend"

  job {
    commands = [
      ["terraform", "init", "-lock-timeout=5m"],
    ]
  }
}

script "preview" {
  name        = "Terraform Deployment Preview"
  description = "Create a preview of Terraform changes and synchronize it to Terramate Cloud"

  job {
    commands = [
      ["terraform", "validate"],
      ["terraform", "plan", "-out", "out.tfplan", "-detailed-exitcode", "-lock=false", {
        mock_on_fail        = true
        enable_sharing      = true
        terraform_plan_file = "out.tfplan"
      }],
    ]
  }
}

script "deploy" {
  name        = "Terraform Deployment"
  description = "Run a full Terraform deployment cycle and synchronize the result to Terramate Cloud"

  job {
    commands = [
      ["terraform", "validate"],
      ["terraform", "plan", "-out", "out.tfplan", "-lock=false"],
      ["terraform", "apply", "-input=false", "-auto-approve", "-lock-timeout=5m","out.tfplan", {
        terraform_plan_file = "out.tfplan"
        enable_sharing      = true
        mock_on_fail        = true
      }],
    ]
  }
}