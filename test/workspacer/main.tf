# TFE_HOSTNAME="" TFE_TOKEN="" terraform apply
locals {
  organization_name = "terraform-tom"
  project_name      = "terraform-agent"
  workspace_name    = "agent-workspace"
  agent_pool_name   = "tt-agent-pool"
}

data "tfe_project" "main" {
  organization = local.organization_name
  name         = local.project_name
}

data "tfe_agent_pool" "main" {
  organization = local.organization_name
  name         = local.agent_pool_name
}

resource "tfe_workspace" "main" {
  name         = local.workspace_name
  organization = local.organization_name
  project_id   = data.tfe_project.main.id
}

resource "tfe_workspace_settings" "main" {
  workspace_id   = tfe_workspace.main.id
  execution_mode = "agent"
  agent_pool_id  = data.tfe_agent_pool.main.id
}

