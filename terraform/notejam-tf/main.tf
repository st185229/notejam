terraform {
  backend "remote" {
    organization = "notejam"

    workspaces {
      name = "nordcloud-nodejam"
    }
  }
}

