workflow "packer validate docker-image-template" {
  resolves = "packer-validate-docker-image-template"
  on = "pull_request"
}

action "filter-open-synced-pr" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "packer-validate-docker-image-template" {
  uses = "dawitnida/packer-github-actions/validate@master"
  needs = "filter-open-synced-pr"
  secrets = [
    "GITHUB_TOKEN",
  ]
  env = {
    TEMPLATE_FILE_NAME = "*.json"
    PACKER_ACTION_WORKING_DIR = "dockers"
  }
}

workflow "packer validate template-x with var-file" {
  resolves = "packer-validate-template-x"
  on = "pull_request"
}

action "packer-validate-template-x" {
  uses = "dawitnida/packer-github-actions/validate@master"
  needs = "filter-open-synced-pr"
  secrets = [
    "GITHUB_TOKEN",
  ]
  args = [
    "-var-file=global-vars.json",
  ]
  env = {
    TEMPLATE_FILE_NAME = "packer-template-x.json"
  }
}

workflow "packer validate template-y without arg" {
  resolves = "packer-validate-template-y"
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