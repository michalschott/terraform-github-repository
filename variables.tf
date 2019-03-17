variable "name" {
  type = "string"

  description = "The name of the repository."
}

variable "description" {
  type = "string"

  default = ""

  description = "A short description of the repository."
}

variable "homepage_url" {
  type = "string"

  default = ""

  description = "A URL with more information about the repository."
}

variable "private" {
  type = "string"

  default = true

  description = "Either `true` to create a private repository or `false` to create a public one."
}

variable "has_issues" {
  type = "string"

  default = true

  description = "Either `true` to enable issues for the repository or `false` to disable them."
}

variable "has_projects" {
  type = "string"

  default = false

  description = "Either `true` to enable projects for the repository or `false` to disable them."
}

variable "has_wiki" {
  type = "string"

  default = false

  description = "Either `true` to enable the wiki for the repository or `false` to disable it."
}

variable "auto_init" {
  type = "string"

  default = false

  description = "Pass `true` to create an initial commit with empty README."
}

variable "gitignore_template" {
  type = "string"

  default = ""

  description = "The name of a gitignore template without the extension. Example: `Terraform` or `VisualStudio`."
}

variable "license_template" {
  type = "string"

  default = ""

  description = "The name of a open source license templaet. Example: `mit` or `mpl-2.0`."
}

variable "allow_squash_merge" {
  type = "string"

  default = true

  description = "Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging."
}

variable "allow_merge_commit" {
  type = "string"

  default = true

  description = "Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits."
}

variable "allow_rebase_merge" {
  type = "string"

  default = true

  description = "Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging."
}

variable "archived" {
  type = "string"

  default = false

  description = "Pass `true` to archive this repository. Note: You cannot unarchive repositories through the API."
}

variable "topics" {
  type = "list"

  default = []

  description = "A list of topics to add to the repository."
}

variable "default_branch" {
  type = "string"

  default = ""

  description = "Updates the default branch for the repository. This can only be set after a repository has been created."
}

variable "collaborators" {
  type = "list"

  default = []

  description = "Add users as collaborators on the repository."
}

variable "teams" {
  type = "list"

  default = []

  description = "Add the repository to a team or update teams permission on the repository."
}

variable "deploy_keys" {
  type = "list"

  default = []

  description = "Add deploy keys (SSH keys) that grants access to the repository."
}

variable "issue_labels" {
  type        = "list"
  default     = []
  description = "Create and manage issue labels for a repository."
}

variable "branch_protection_enabled" {
  type        = "string"
  default     = 1
  description = "Enable branch protection."
}

variable "branch_protection_enforce_admins" {
  type        = "string"
  default     = false
  description = "Enforce status checks for repository administrators."
}

variable "branch_protection_strict" {
  type        = "string"
  default     = true
  description = "Require branches to be up to date before merging."
}

variable "branch_protection_contexts" {
  type        = "list"
  default     = []
  description = "The list of status checks to require in order to merge into this branch."
}

variable "branch_protection_dismiss_stale_reviews" {
  type        = "string"
  default     = true
  description = "Dismiss approved reviews automatically when a new commit is pushed."
}

variable "branch_protection_dismissal_users" {
  type        = "list"
  default     = []
  description = "The list of user logins with dismissal access."
}

variable "branch_protection_dismissal_teams" {
  type        = "list"
  default     = []
  description = "The list of team slugs with dismissal access."
}

variable "branch_protection_require_code_owner_reviews" {
  type        = "string"
  default     = false
  description = "Require an approved review in pull requests including files with a designated code owner."
}

variable "branch_protection_restrictions_users" {
  type        = "list"
  default     = []
  description = "The list of user logins with push access."
}

variable "branch_protection_restrictions_teams" {
  type        = "list"
  default     = []
  description = "The list of team slugs with push access."
}
