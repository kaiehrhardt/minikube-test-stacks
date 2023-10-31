run "setup_gitlab" {
  variables {
    cpus   = 2
    memory = "4096mb"
  }
}

run "verify" {
  module {
    source = "./tests/verify"
  }

  assert {
    condition     = data.terracurl_request.test.status_code == "200"
    error_message = "terracurl failed"
  }
}
