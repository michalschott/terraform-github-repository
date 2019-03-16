module "repository_labels" {
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
}
