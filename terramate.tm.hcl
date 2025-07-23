terramate {
  required_version = "0.14.0"
  config {
    # disable_safeguards = ["git-untracked", "git-uncommitted"]
    experiments = [
      "scripts",
      "outputs-sharing",
      "tmgen"
    ]
  }
}
