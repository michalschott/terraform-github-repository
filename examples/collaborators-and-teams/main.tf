module "repository" {
  source = "../"

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
