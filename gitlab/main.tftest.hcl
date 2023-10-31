run "setup_gitlab" {}

run "verify" {
  variables {
    mk_ip = run.setup_gitlab.ip
  }

  module {
    source = "./tests/verify"
  }

  assert {
    condition     = data.terracurl_request.test.status_code == "200"
    error_message = "terracurl failed"
  }
}
