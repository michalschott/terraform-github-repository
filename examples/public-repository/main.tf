module "repository" {
  source = "../"

  name = "example"

  description = "My example codebase"

  private = false

  gitignore_template = "Node"
  license_template   = "mit"

  topics = ["example"]
}
