module "repository_bp" {
  source = "../"

  name               = "example"
  description        = "My example codebase"
  private            = false
  gitignore_template = "Node"
  license_template   = "mit"
  topics             = ["example"]

  issue_labels = [{
    name        = "kind/bug"
    color       = "D73A4A"
    description = "Something isn't working"
  }]

  branch_protection_enabled                    = 1
  branch_protection_enforce_admins             = true
  branch_protection_strict                     = true
  branch_protection_contexts                   = ["ci/travis"]
  branch_protection_dismiss_stale_reviews      = true
  branch_protection_dismissal_users            = []
  branch_protection_dismissal_teams            = []
  branch_protection_require_code_owner_reviews = false
  branch_protection_restrictions_users         = []
  branch_protection_restrictions_teams         = []
}
