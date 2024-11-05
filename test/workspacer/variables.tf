resource "tfe_variable" "sleep" {
  workspace_id = tfe_workspace.main.id
  key          = "sleep"
  value        = "1200"
  category     = "terraform"
}

# resource "tfe_variable" "TERRAFORM_NETWORK_MIRROR_URL" {
#   workspace_id = tfe_workspace.main.id
#   key          = "TERRAFORM_NETWORK_MIRROR_URL"
#   value        = "https://google.com"
#   category     = "env"
# }

resource "tfe_variable" "AGENT_PRE_PLAN_B64" {
  workspace_id = tfe_workspace.main.id
  key          = "AGENT_PRE_PLAN_B64"
  value = base64encode(<<-EOT
    #!/bin/bash
    echo "This is a multiline script example."
    echo "It will be encoded in base64."
    # Add more lines as needed
  EOT
  )
  category = "env"
}
