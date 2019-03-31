resource "github_repository" "main" {
  name = var.name

  description = var.description

  homepage_url = var.homepage_url

  private = var.private

  has_issues   = var.has_issues
  has_projects = var.has_projects
  has_wiki     = var.has_wiki

  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge

  auto_init = var.auto_init

  gitignore_template = var.gitignore_template
  license_template   = var.license_template

  default_branch = var.default_branch

  archived = var.archived

  topics = var.topics
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
  count      = length(var.deploy_keys)
  title      = lookup(var.deploy_keys[count.index], "title", "")
  repository = github_repository.main.name
  key        = var.deploy_keys[count.index].key
  read_only  = lookup(var.deploy_keys[count.index], "read_only", true)
}

resource "github_branch_protection" "main" {
  count = length(var.branch_protection)

  repository = github_repository.main.name

  branch = var.branch_protection[count.index].branch

  enforce_admins = lookup(var.branch_protection[count.index], "enforce_admins", null)

  dynamic "required_status_checks" {
    for_each = (
      lookup(var.branch_protection[count.index], "required_status_checks", null) != null ?
      [var.branch_protection[count.index].required_status_checks] :
      []
    )

    content {
      strict   = lookup(required_status_checks.value, "strict", null)
      contexts = lookup(required_status_checks.value, "contexts", null)
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = (
      lookup(var.branch_protection[count.index], "required_pull_request_reviews", null) != null ?
      [var.branch_protection[count.index].required_pull_request_reviews] :
      []
    )

    content {
      dismiss_stale_reviews      = lookup(required_pull_request_reviews.value, "dismiss_stale_reviews", null)
      dismissal_users            = lookup(required_pull_request_reviews.value, "dismissal_users", null)
      dismissal_teams            = lookup(required_pull_request_reviews.value, "dismissal_teams", null)
      require_code_owner_reviews = lookup(required_pull_request_reviews.value, "require_code_owner_reviews", null)
    }
  }

  dynamic "restrictions" {
    for_each = (
      lookup(var.branch_protection[count.index], "restrictions", null) != null ?
      [var.branch_protection[count.index].restrictions] :
      []
    )

    content {
      users = lookup(restrictions.value, "users", null)
      teams = lookup(restrictions.value, "teams", null)
    }
  }
}