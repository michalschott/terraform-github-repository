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

### Configure branch protection

```hcl
module "repository" {
  source = "innovationnorway/repository/github"

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
| `branch_protection` | `list` | Configure branch protection on the repository. |

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

The `deploy_keys` object must have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `title` | `string` | A name for the key. |
| `key` | `string` | The contents of the key. |
| `read_only` | `bool` | Deploy keys with write access can perform the same actions as an organization member with admin access, or a collaborator on a personal repository. Default: `true`. |

The `branch_protection` object can have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `branch` | `string` | The branch name. |
| `enforce_admins` | `bool` | Enforce all configured restrictions for administrators. Set to `true` to enforce required status checks for repository administrators.  |
| `required_status_checks` | `object` | Require status checks to pass before merging. |
| `required_pull_request_reviews` | `object` | Require at least one approving review on a pull request, before merging. |
| `restrictions` | `object` | Restrict who can push to this branch. |

The `required_status_checks` object can have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `strict` | `bool` | Require branches to be up to date before merging. |
| `contexts` | `list` | The list of status checks to require in order to merge into this branch. |

The `required_pull_request_reviews` object can have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `dismissal_users` | `list` | The list of user `login`s with dismissal access. |
| `dismissal_teams` | `list` | The list of team `slug`s with dismissal access. |
| `dismiss_stale_reviews` | `bool` | Set to `true` if you want to automatically dismiss approving reviews when someone pushes a new commit. |
| `require_code_owner_reviews` | `bool` | Blocks merging pull requests until [code owners](https://help.github.com/articles/about-code-owners/) review them. |

The `restrictions` object must have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `users` | `list` | The list of user `login`s with push access. |
| `teams` | `list` | The list of team `slug`s with push access. |

## Limitations

Due to current limitations of the Terraform language, items added or removed from the `branch_protection`, `collaborators`, `teams` and `deploy_keys` lists, will also update subsequent items with indexes greater than where the addition or removal was made. 
