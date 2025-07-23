terramate {
  required_version = "0.14.0"
  config {
    git {
      default_branch = "main"
    }
    # disable_safeguards = ["git-untracked", "git-uncommitted"]
    experiments = [
      "scripts",
      "outputs-sharing",
      "tmgen"
    ]
  }
}
