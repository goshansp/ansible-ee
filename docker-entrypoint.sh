#!/bin/bash
SSH_KEY_PATH="${HOME}/.ssh/id_ecdsa"
if [ ! -f "$SSH_KEY_PATH" ]; then
  mkdir -p "${HOME}/.ssh"
  ssh-keygen -t ecdsa -N "" -f "$SSH_KEY_PATH"
  echo "Generated new SSH keypair at $SSH_KEY_PATH"
fi
exec "$@"
