# #!/usr/bin/env bash
# set -euo pipefail
# if [[ -z "${SSH_AUTH_SOCK:-}" || ! -S "${SSH_AUTH_SOCK:-}" ]]; then
#   eval "$(ssh-agent -s)" >/dev/null
#   trap 'ssh-agent -k >/dev/null' EXIT
#   [[ -f "$HOME/.ssh/id_ed25519" ]] && ssh-add "$HOME/.ssh/id_ed25519" >/dev/null
# fi

docker compose run --rm \
  --user "$(id -u):$(id -g)" \
  --entrypoint /bin/bash \
  pi-agent
