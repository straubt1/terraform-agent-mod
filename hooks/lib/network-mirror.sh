#!/bin/bash
# Create a network mirror
# Environment Variables:
#   - TERRAFORM_NETWORK_MIRROR_URL
#   - TERRAFORM_NETWORK_MIRROR_PATH

if [[ -n "$TERRAFORM_NETWORK_MIRROR_PATH" ]]; then
  echo "TERRAFORM_NETWORK_MIRROR_PATH is set, updating the .terraformrc file"
  echo "  PATH: '${TERRAFORM_NETWORK_MIRROR_PATH}'"

  cat >> "${HOME}/.terraformrc" << EOF

provider_installation {
  filesystem_mirror {
    path = "${TERRAFORM_NETWORK_MIRROR_PATH}"
    include = ["registry.terraform.io/*/*"]
  }
}
EOF

fi

if [[ -n "$TERRAFORM_NETWORK_MIRROR_URL" ]]; then
  echo "TERRAFORM_NETWORK_MIRROR_URL is set, updating the .terraformrc file"
  echo "  URL: '${TERRAFORM_NETWORK_MIRROR_URL}'"

  cat >> "${HOME}/.terraformrc" << EOF

provider_installation {
  network_mirror {
    url = "${TERRAFORM_NETWORK_MIRROR_URL}"
  }
}
EOF
fi