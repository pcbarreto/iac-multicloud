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
      ["terramate", "run", "--tags=dev", "--", "terraform", "plan", "-out", "plan.out", "-detailed-exitcode", "-lock=false", {
        terraform_plan_file = "plan.out"
        mock_on_fail        = true,
        enable_sharing      = true,
      }],
    ]
  }
}