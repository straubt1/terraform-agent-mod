#!/bin/bash
# Execute a run specific script
# Arguments:
#   - "stage": The name of the stage, one of the following: "PRE_PLAN" "POST_PLAN" "PRE_APPLY" "POST_APPLY"

allowed_vars=("PRE_PLAN" "POST_PLAN" "PRE_APPLY" "POST_APPLY")
stage=$1

# Check if the provided variable name is in the list of allowed variables
if ! [[ " ${allowed_vars[*]} " =~ " ${stage} " ]]; then
  echo "The environment variable '$stage' is not allowed. Please use one of the following: ${allowed_vars[*]}"
  exit 1
fi

# B64 - Build the name of the ENV Variable based:
# `AGENT_PRE_PLAN_B64`
# `AGENT_POST_PLAN_B64`
# `AGENT_PRE_APPLY_B64`
# `AGENT_POST_APPLY_B64`
env_var_name_b64="AGENT_${1}_B64"

if [ -n "${!env_var_name_b64+x}" ]; then
  echo "${env_var_name_b64} is set, Decoding and executing"
  
  # Get the value and decode it
  encoded_content="${!env_var_name_b64}"
  decoded_content=$(echo "$encoded_content" | base64 --decode)

  # Execute the decoded content
  eval "$decoded_content"
fi

# PATH - Build the name of the ENV Variable based:
# `AGENT_PRE_PLAN_PATH`
# `AGENT_POST_PLAN_PATH`
# `AGENT_PRE_APPLY_PATH`
# `AGENT_POST_APPLY_PATH`
env_var_name_path="AGENT_${1}_PATH"

if [ -n "${!env_var_name_path+x}" ]; then
  echo "${env_var_name_path} is set, Reading file and executing"
  
  script_path="${!env_var_name_path}"

  # chmod +x ${script_path}
  # Execute the script
  eval "$script_path"
fi