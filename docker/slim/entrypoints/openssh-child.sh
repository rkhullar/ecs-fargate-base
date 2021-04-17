#!/usr/bin/env sh

echo "currently running as `whoami`"
# TODO: confirm current user is ssh-user or member of sudo

if [ -z "${TARGET_USER}" ]; then
  echo "need value for TARGET_USER env variable"
  exit 1
fi

/opt/docker/entrypoints/openssh.sh
echo "about to run $@ as ${TARGET_USER}"
sudo -E gosu ${TARGET_USER} "$@"

## assume we are ssh-user
## run /opt/docker/entrypoint/openssh.sh
## sudo su ${USER} # switch to target user
## then forward commands
