# terraform-agent-mod

Custom Terraform Agent to allow for more flexible workflows in Terraform Enterprise or HCP Terraform. This Docker image can replace the built in Pipeline Image in Terraform Enterprise, or be used in an Agent Pool.

## Features

Each of these features can be activated with a Workspace Environment Variable, this can also be set as a Variable Set at the Project level. This approach may not work in a production setting, but gives variable options while designing or implementing a PoC to determine what is possible.

### Network Mirror

In order to leverage a [Provider Network Mirror](https://developer.hashicorp.com/terraform/internals/provider-network-mirror-protocol) in Terraform to source Providers requires a Terraform CLI configuration. This step must be done in the "pre-plan" and "pre-apply" stages.

The challenge is that this CLI Configuration is automatically created during a run and has important token's in it for the run to operate. This means we must append to the `.terraformrc` file dynamically.

**Variables**

* `TERRAFORM_NETWORK_MIRROR_URL`
  * If set, the URL will be injected into the `.terraformrc` file.
  * Example:
  ```
  provider_installation {
    network_mirror {
      url = "${TERRAFORM_NETWORK_MIRROR_URL}"
    }
  }
  ```
* `TERRAFORM_NETWORK_MIRROR_PATH`
  * If set, the path will be injected into the `.terraformrc` file.
  * Note: This requires that the mirror files be contained within the image.
  * Example:
  ```
  provider_installation {
    filesystem_mirror {
      path = "${TERRAFORM_NETWORK_MIRROR_PATH}"
      include = ["registry.terraform.io/*/*"]
    }
  }
  ```

### Run Specific Script

There are times where a script needs to be executed at one of the hook stages. If we provide the Workspace with that script, we can execute. This features gives us two options to do this.

#### Variables - Base64 Encoded Script

If one of the following is set, the variable will be decoded and executed in its designated stage:
* `AGENT_PRE_PLAN_B64`
* `AGENT_POST_PLAN_B64`
* `AGENT_PRE_APPLY_B64`
* `AGENT_POST_APPLY_B64`

#### Variables - Path to Script

Note: The path point to an executable bash script and it must include a dot-slash. Example "./test.sh".

If one of the following is set, the variable will point to a file in the Workspace and executed in its designated stage:
* `AGENT_PRE_PLAN_PATH`
* `AGENT_POST_PLAN_PATH`
* `AGENT_PRE_APPLY_PATH`
* `AGENT_POST_APPLY_PATH`

## Agent Runtime

Helpful information when creating and working with custom Agents.

Agent Run `pwd` = "/home/tfc-agent/.tfc-agent/component/terraform/runs/{RUN_ID}/config"

Available Environment Variables in the Run:

```
ATLAS_ADDRESS=https://tfe.hc-6be5777e989c4fab8c400322fcb.gcp.sbx.hashicorpdemo.com
ATLAS_CONFIGURATION_NAME=agent-workspace-1
ATLAS_CONFIGURATION_SLUG=terraform-tom/agent-workspace-1
ATLAS_CONFIGURATION_VERSION=
ATLAS_CONFIGURATION_VERSION_GITHUB_BRANCH=
ATLAS_CONFIGURATION_VERSION_GITHUB_COMMIT_SHA=
ATLAS_CONFIGURATION_VERSION_GITHUB_TAG=
ATLAS_RUN_ID=run-eEMVMw45sDJdZSsk
ATLAS_TOKEN=
ATLAS_WORKSPACE_NAME=agent-workspace-1
ATLAS_WORKSPACE_SLUG=terraform-tom/agent-workspace-1
CHECKPOINT_DISABLE=1
HOME=/home/tfc-agent/.tfc-agent/component/terraform/runs/run-eEMVMw45sDJdZSsk
PWD=/home/tfc-agent/.tfc-agent/component/terraform/runs/run-eEMVMw45sDJdZSsk/config
SHLVL=1
TF_ATLAS_DIR=
TF_IN_AUTOMATION=1
TF_INPUT=0
TF_REGISTRY_DISCOVERY_RETRY=2
TF_TOKEN_tfe_hc__{projectid}_gcp_sbx_hashicorpdemo_com=
TF_VAR_ATLAS_ADDRESS=https://tfe.hc-{projectid}.gcp.sbx.hashicorpdemo.com
TF_VAR_ATLAS_CONFIGURATION_NAME=agent-workspace-1
TF_VAR_ATLAS_CONFIGURATION_SLUG=terraform-tom/agent-workspace-1
TF_VAR_ATLAS_CONFIGURATION_VERSION=
TF_VAR_ATLAS_CONFIGURATION_VERSION_GITHUB_BRANCH=
TF_VAR_ATLAS_CONFIGURATION_VERSION_GITHUB_COMMIT_SHA=
TF_VAR_ATLAS_CONFIGURATION_VERSION_GITHUB_TAG=
TF_VAR_ATLAS_RUN_ID=run-eEMVMw45sDJdZSsk
TF_VAR_ATLAS_WORKSPACE_NAME=agent-workspace-1
TF_VAR_ATLAS_WORKSPACE_SLUG=terraform-tom/agent-workspace
TF_VAR_TFC_CONFIGURATION_VERSION_GIT_BRANCH=
TF_VAR_TFC_CONFIGURATION_VERSION_GIT_COMMIT_SHA=
TF_VAR_TFC_CONFIGURATION_VERSION_GIT_TAG=
TF_VAR_TFC_PROJECT_NAME=terraform-agent
TF_VAR_TFC_RUN_ID=run-eEMVMw45sDJdZSsk
TF_VAR_TFC_WORKSPACE_ID=ws-BNLHjSb5gagjgHwN
TF_VAR_TFC_WORKSPACE_NAME=agent-workspace-1
TF_VAR_TFC_WORKSPACE_SLUG=terraform-tom/agent-workspace-1
TF_VAR_TFE_RUN_ID=run-eEMVMw45sDJdZSsk
TF_VAR_TF_ATLAS_DIR=
TF_X_SHADOW=0
TFC_AGENT_ENV=/home/tfc-agent/.tfc-agent/component/terraform/runs/run-eEMVMw45sDJdZSsk/env
TFC_CONFIGURATION_VERSION_GIT_BRANCH=
TFC_CONFIGURATION_VERSION_GIT_COMMIT_SHA=
TFC_CONFIGURATION_VERSION_GIT_TAG=
TFC_PROJECT_NAME=terraform-agent
TFC_RUN_ID=run-eEMVMw45sDJdZSsk
TFC_WORKSPACE_ID=ws-BNLHjSb5gagjgHwN
TFC_WORKSPACE_NAME=agent-workspace-1
TFC_WORKSPACE_SLUG=terraform-tom/agent-workspace-1
TFE_RUN_ID=run-eEMVMw45sDJdZSsk
_=/usr/bin/printenv
```
