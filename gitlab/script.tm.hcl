script "deploy" "gitlab" {
  description = "deploy"
  job {
    description = "deploy"
    commands = [
      ["terraform", "init", "-upgrade", "-reconfigure"],
      ["terraform", "validate"],
      ["terraform", "apply", "-auto-approve"],
    ]
  }
}

script "destroy" "gitlab" {
  description = "destroy"
  job {
    description = "destroy"
    commands = [
      ["terraform", "destroy", "-auto-approve"],
    ]
  }
}
