terramate {
    required_version = "~> 0.7"
}

terramate {
  config {
    git {
      default_branch = "master"
    }
    disable_safeguards = ["all"]
    experiments = ["scripts"]
  }
}
