workflow "packer build template-y" {
  resolves = "packer-build-template-y"
  on = "release"
}

action "packer-build-template-y" {
  uses = "dawitnida/packer-github-actions/build@master"
  needs = "packer-inspect-template-y"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TEMPLATE_FILE_NAME = "packer-template-y.json"
  }
}

action "filter-open-synced-pr" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

workflow "packer inspect & validate template-y" {
  resolves = "packer-inspect-template-y"
  on = "pull_request"
}

action "packer-validate-template-y" {
  uses = "dawitnida/packer-github-actions/validate@master"
  needs = "filter-open-synced-pr"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TEMPLATE_FILE_NAME = "packer-template-y.json"
  }
}

action "packer-inspect-template-y" {
  uses = "dawitnida/packer-github-actions/inspect@master"
  needs = "packer-validate-template-y"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TEMPLATE_FILE_NAME = "packer-template-y.json"
  }
}