variable "name" {
  type        = string
  description = "The name of the repository."
}

variable "description" {
  type        = string
  default     = null
  description = "A short description of the repository."
}

variable "homepage_url" {
  type        = string
  default     = null
  description = "A URL with more information about the repository."
}

variable "private" {
  type        = bool
  default     = true
  description = "Either `true` to create a private repository or `false` to create a public one."
}

variable "has_issues" {
  type        = bool
  default     = true
  description = "Either `true` to enable issues for the repository or `false` to disable them."
}

variable "has_projects" {
  type        = bool
  default     = false
  description = "Either `true` to enable projects for the repository or `false` to disable them."
}

variable "has_wiki" {
  type        = bool
  default     = false
  description = "Either `true` to enable the wiki for the repository or `false` to disable it."
}

variable "auto_init" {
  type        = bool
  default     = false
  description = "Pass `true` to create an initial commit with empty README."
}

variable "gitignore_template" {
  type        = string
  default     = null
  description = "The name of a gitignore template without the extension. Example: `Terraform` or `VisualStudio`."
}

variable "license_template" {
  type        = string
  default     = null
  description = "The name of a open source license templaet. Example: `mit` or `mpl-2.0`."
}

variable "allow_squash_merge" {
  type        = bool
  default     = true
  description = "Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging."
}

variable "allow_merge_commit" {
  type        = bool
  default     = true
  description = "Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits."
}

variable "allow_rebase_merge" {
  type        = bool
  default     = true
  description = "Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging."
}

variable "archived" {
  type        = bool
  default     = false
  description = "Pass `true` to archive this repository. Note: You cannot unarchive repositories through the API."
}

variable "topics" {
  type        = list(string)
  default     = []
  description = "A list of topics to add to the repository."
}

variable "default_branch" {
  type        = string
  default     = null
  description = "Updates the default branch for the repository. This can only be set after a repository has been created."
}

variable "collaborators" {
  type = list(object({
    username   = string
    permission = string
  }))
  default     = []
  description = "Add users as collaborators on the repository."
}

variable "teams" {
  type = list(object({
    name       = string
    permission = string
  }))
  default     = []
  description = "Add the repository to a team or update teams permission on the repository."
}

variable "deploy_keys" {
  type        = any
  default     = []
  description = "Add deploy keys (SSH keys) that grants access to the repository."
}

variable "branch_protection" {
  type        = any
  default     = []
  description = "Configure branch protection on the repository."
}
