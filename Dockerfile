FROM hashicorp/tfc-agent:latest
RUN mkdir -p /home/tfc-agent/.tfc-agent
ADD --chown=tfc-agent:tfc-agent hooks /home/tfc-agent/.tfc-agent/hooks

RUN mkdir -p /home/tfc-agent/mirror
ADD --chown=tfc-agent:tfc-agent network_mirror /home/tfc-agent/mirror

# Set Hook Timeouts to MAX, https://github.com/hashicorp/tfc-agent/pull/820
ENV TFC_AGENT_HOOK_PRE_PLAN_TIMEOUT=600
ENV TFC_AGENT_HOOK_POST_PLAN_TIMEOUT=600
ENV TFC_AGENT_HOOK_PRE_APPLY_TIMEOUT=600
ENV TFC_AGENT_HOOK_POST_APPLY_TIMEOUT=600
