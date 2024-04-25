script "deploy" "runner" {
  description = "deploy"
  job {
    description = "deploy"
    commands = [
      ["terraform", "init"],
      ["terraform", "validate"],
      ["terraform", "apply", "-auto-approve"],
    ]
  }
}

script "destroy" "runner" {
  description = "destroy"
  job {
    description = "destroy"
    commands = [
      ["terraform", "destroy", "-auto-approve"],
    ]
  }
}
