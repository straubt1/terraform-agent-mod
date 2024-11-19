FROM hashicorp/tfc-agent:latest
LABEL org.opencontainers.image.description "Custom Terraform Agent to allow for more flexible workflows in Terraform Enterprise or HCP Terraform."

RUN mkdir -p /home/tfc-agent/.tfc-agent
ADD --chown=tfc-agent:tfc-agent hooks /home/tfc-agent/.tfc-agent/hooks

RUN mkdir -p /home/tfc-agent/mirror
ADD --chown=tfc-agent:tfc-agent network_mirror /home/tfc-agent/mirror

