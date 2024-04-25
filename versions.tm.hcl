generate_hcl "_generated_versions.tf" {
  lets {
    required_providers = { for k, v in tm_try(global.terraform.provider, {}) :
      k => {
        source  = v.source
        version = v.version
      } if tm_length(tm_split(".", k)) == 1
    }
  }
  content {
    terraform {
      required_version = global.terraform.version
    }
    terraform {
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }
  }
}
