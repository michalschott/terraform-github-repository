module "repository" {
  source = "../"

  name = "example"

  description = "My example codebase"

  branch_protection = [
    {
      branch = "master"

      required_status_checks = {
        strict   = true
        contexts = ["terraform-fmt"]
      }

      required_pull_request_reviews = {
        dismiss_stale_reviews      = true
        require_code_owner_reviews = true
      }
    },
  ]
}
