locals {
  deploy_keys = [
    for d in var.deploy_keys : merge({
      title     = substr(d.key, 0, 26)
      key       = null
      read_only = true
    }, d)
  ]

  branch_protection = [
    for b in var.branch_protection : merge({
      branch                        = null
      enforce_admins                = null
      required_status_checks        = []
      required_pull_request_reviews = []
      restrictions                  = []
    }, b)
  ]

  required_status_checks = [
    for b in local.branch_protection : [
      for r in b.required_status_checks[*] : merge({
        strict   = null
        contexts = []
      }, r)
    ]
  ]

  required_pull_request_reviews = [
    for b in local.branch_protection : [
      for r in b.required_pull_request_reviews[*] : merge({
        dismiss_stale_reviews      = true
        dismissal_users            = []
        dismissal_teams            = []
        require_code_owner_reviews = null
      }, r)
    ]
  ]

  restrictions = [
    for b in local.branch_protection : [
      for r in b.restrictions[*] : merge({
        users = []
        teams = []
      }, r)
    ]
  ]
}

resource "github_repository" "main" {
  name               = var.name
  description        = var.description
  homepage_url       = var.homepage_url
  private            = var.private
  has_issues         = var.has_issues
  has_projects       = var.has_projects
  has_wiki           = var.has_wiki
  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge
  auto_init          = var.auto_init
  gitignore_template = var.gitignore_template
  license_template   = var.license_template
  default_branch     = var.default_branch
  archived           = var.archived
  topics             = var.topics
}

resource "github_repository_collaborator" "main" {
  count      = length(var.collaborators)
  repository = github_repository.main.name
  username   = var.collaborators[count.index].username
  permission = var.collaborators[count.index].permission
}

data "github_team" "main" {
  count = length(var.teams)
  slug  = var.teams[count.index].name
}

resource "github_team_repository" "main" {
  count      = length(var.teams)
  team_id    = data.github_team.main[count.index].id
  repository = github_repository.main.name
  permission = var.teams[count.index].permission
}

resource "github_repository_deploy_key" "main" {
  count      = length(local.deploy_keys)
  title      = local.deploy_keys[count.index].title
  repository = github_repository.main.name
  key        = local.deploy_keys[count.index].key
  read_only  = local.deploy_keys[count.index].read_only
}

resource "github_branch_protection" "main" {
  count          = length(local.branch_protection)
  repository     = github_repository.main.name
  branch         = local.branch_protection[count.index].branch
  enforce_admins = local.branch_protection[count.index].enforce_admins

  dynamic "required_status_checks" {
    for_each = local.required_status_checks[count.index]

    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = local.required_pull_request_reviews[count.index]

    content {
      dismiss_stale_reviews      = required_pull_request_reviews.value.dismiss_stale_reviews
      dismissal_users            = required_pull_request_reviews.value.dismissal_users
      dismissal_teams            = required_pull_request_reviews.value.dismissal_teams
      require_code_owner_reviews = required_pull_request_reviews.value.require_code_owner_reviews
    }
  }

  dynamic "restrictions" {
    for_each = local.restrictions[count.index]

    content {
      users = restrictions.value.users
      teams = restrictions.value.teams
    }
  }
}
