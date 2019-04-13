module "repository" {
  source = "../"

  name = "example"

  description = "My example codebase"

  deploy_keys = [
    {
      title = "example-key"
      key   = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgycF4s5wqx2WNM/fSqGZpWbg/z8nPhvHtA5Ti5lXkTzwjqLlYxj6h7EdzJco3kNTaFkQIw7TUHmnFpUJM+w4lpEVu/zYq+0W0HxlRcQ4C/HOYcn26jfGJfalI5uZpry1x85VQB/2tgVw6Jbh6sT8+FdoA+HQxk+pCFuht3V/UBX/P9KHLw4TPPkSe9P84664st7ztm2wy+c+0ohKwM6kkhUKKVYK1e2lWS9NUzeKllU4/mIDBJlj8gjEEFuKuKi2vs9/RLsjRsE/Qz2fpuOe+RhSdT+7IFQ7Ye4vEhJ8ZKko5WiJDokzIJYBQWQ2phhctgJhg/yi51IxUSiXNqzRNQ=="

      read_only = true
    },
  ]
}
