terramate {
  required_version = ">= 0.8.0"
  config {
    git {
      default_branch = "master"
    }
    disable_safeguards = ["all"]
    experiments = ["scripts"]
  }
}