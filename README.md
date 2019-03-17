# GitHub Repository

Create a new repository.

## Example Usage

### Create public (e.g. open source) repository

```hcl
module "repository" {
  source = "innovationnorway/repository/github"

  name = "example"

  description = "My example codebase"

  private = false

  gitignore_template = "Node"
  license_template   = "mit"

  topics = ["example"]
}
```

### Add collaborators and teams

```hcl
module "repository" {
  source = "innovationnorway/repository/github"

  name = "example"

  description = "My example codebase"

  collaborators = [
    {
      username   = "joakimhellum-in"
      permission = "push"
    },
    {
      username   = "innovationnorway-bot"
      permission = "pull"
    },
  ]

  teams = [
    {
      name       = "terraform"
      permission = "push"
    },
    {
      name       = "security"
      permission = "pull"
    },
  ]
}
```

### Add deploy keys

```hcl
module "repository" {
  source = "innovationnorway/repository/github"

  name = "example"

  description = "My example codebase"

  deploy_keys = [
    {
      title = "example-key"
      key   = "ssh-rsa AAAAB3NzaC1yc2EAAA..."

      read_only = true
    },
  ]
}
```

## Arguments

| Name | Type | Description |
| --- | ---| --- |
| `name` | `string` | **Required**. The name of the repository. |
| `description` | `string` | A short description of the repository. |
| `homepage_url` | `string` | A URL with more information about the repository. |
| `private` | `bool` | Either `true` to create a private repository or `false` to create a public one. Creating private repositories requires a paid GitHub account. Default: `true`. |
| `has_issues` | `bool` | Either `true` to enable issues for the repository or `false` to disable them. Default: `true`. |
| `has_projects` | `bool` | Either `true` to enable projects for the repository or `false` to disable them. Default: `false`. |
| `has_wiki` | `bool` | Either `true` to enable the wiki for the repository or `false` to disable it. Default: `false`. |
| `auto_init` | `bool` | Pass `true` to create an initial commit with empty `README.md`. Default: `false`. |
| `gitignore_template` | `string` | Desired language or platform [.gitignore template](https://github.com/github/gitignore) to apply. Use the name of the template without the extension. For example: `Terraform` or `VisualStudio`. |
| `license_template` | `string` | Choose an [open source license template](https://choosealicense.com/) that best suits your needs, and then use the [license keyword](https://help.github.com/articles/licensing-a-repository/#searching-github-by-license-type) as the `license_template` string. For example: `mit` or `mpl-2.0`. |
| `allow_squash_merge` | `bool` | Either `true` to allow squash-merging pull requests, or `false` to prevent squash-merging. Default: `true`. |
| `allow_merge_commit` | `bool` | Either `true` to allow merging pull requests with a merge commit, or `false` to prevent merging pull requests with merge commits. Default: `true`. |
| `allow_rebase_merge` | `bool` | Either `true` to allow rebase-merging pull requests, or `false` to prevent rebase-merging. Default: `true`. |
| `archived` | `bool` | Pass `true` to archive the repository. **Note:** You cannot unarchive repositories through the API. Default: `false`. |
| `topics` | `list` | A list of topics to add to the repository. Pass one or more topics to replace the set of existing topics. Send an empty list (`[]`) to clear all topics from the repository. |
| `default_branch` | `string` | Updates the default branch for the repository. **Note**: This can only be set after a repository has been created, and after a correct reference has been created for the target branch inside the repository. |
| `collaborators` | `list` | Add users as collaborators on the repository. |
| `teams` | `list` | Add the repository to a team or update teams permission on the repository. |
| `deploy_keys` | `list` | Add deploy keys (SSH keys) that grants access to the repository. |

If enabled, `branch_protection` adds the the following keys:

| Name | Type | Description |
| --- | --- | --- |
|`branch_protection_enabled`|`string`|Enable branch protection for the default branch|
|`branch_protection_enforce_admins`|`string`|Setting this to true enforces status checks for repository administrators. Default: `false`|
|`branch_protection_strict`|`string`|Require branches to be up to date before merging. Default: `true`|
|`branch_protection_contexts`|`list`|The list of status checks to require in order to merge into this branch. Default: `[]`|
|`branch_protection_dismiss_stale_reviews`|`string`|Dismiss approved reviews automatically when a new commit is pushed. Default: `true`.|
|`branch_protection_dismissal_users`|`list`|The list of user logins with dismissal access. Default: `[]`|
|`branch_protection_dismissal_teams`|`list`|The list of team slugs with dismissal access. Always use slug of the team, not its name. Each team already has to have access to the repository. Default: `[]`|
|`branch_protection_require_code_owner_reviews`|`string`|Require an approved review in pull requests including files with a designated code owner. Default: `false`|
|`branch_protection_restrictions_users`|`list`|The list of user logins with push access. Default: `[]`|
|`branch_protection_restrictions_teams`|`list`|The list of team slugs with push access. Always use slug of the team, not its name. Each team already has to have access to the repository. Default: `[]`|

Note that`branch_protection` only applies to the default branch of the repository.

The `collaborators` object must have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `username` | `string` | The user to add to the repository as a collaborator. |
| `permission` | `string` | The permission to grant the collaborator. Can be one of: <br> * `pull` - can pull, but not push to or administer this repository. <br> * `push` - can pull and push, but not administer this repository. <br> * `admin` - can pull, push and administer this repository. |

The `teams` object must have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The `slug` of a team to be granted access on the repository. |
| `permission` | `string` | The permission to grant the team on this repository. Can be one of: <br> * `pull` - team members can pull, but not push to or administer this repository. <br> * `push` - team members can pull and push, but not administer this repository. <br> * `admin` - team members can pull, push and administer this repository. |

The `deploy_keys` object accepts the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `title` | `string` | A name for the key. |
| `key` | `string` | **Required**. The contents of the key. |
| `read_only` | `bool` | Deploy keys with write access can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. Default: `true`. |

The `issue_labels` object accepts the following keys:
| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | **Required**. The name of the label. |
| `color` | `string` | A 6 character hex code, without the leading #, identifying the color of the label. |
| `description` | `string` | A short description of the label.

## Limitations

Due to current limitations of the Terraform language, items added or removed from the `collaborators`, `teams` and `deploy_keys` lists, will also update subsequent items with indexes greater than where the addition or removal was made.
