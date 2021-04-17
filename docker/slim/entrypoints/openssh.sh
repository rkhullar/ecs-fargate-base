#!/usr/bin/env sh

# store environments variables to load in future shell sessions
# https://stackoverflow.com/questions/34630571/docker-env-variables-not-set-while-log-via-shell
export ENV_FILTER="^(HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=|ENABLE_SSH=|SSH_PORT=|AUTHORIZED_KEYS=|GPG_KEY=|PATH=|ENV_FILTER=|TARGET_USER=)"
env | egrep -v ${ENV_FILTER} | sudo tee -a /etc/environment > /dev/null

if [ "${ENABLE_SSH}" = "true" ] || [ "${ENABLE_SSH}" = 1 ]; then

  if [ -z "${AUTHORIZED_KEYS}" ]; then
    echo "need your ssh public key as AUTHORIZED_KEYS env variable"
    exit 1
  fi

  echo "populating ~/.ssh/authorized_keys with the value from AUTHORIZED_KEYS env variable"
  mkdir -p ~/.ssh && echo "${AUTHORIZED_KEYS}" > ~/.ssh/authorized_keys

  echo "setting ssh port to ${SSH_PORT}"
  sudo sed -i "s|#Port 22|Port ${SSH_PORT}|g" /etc/ssh/sshd_config

  sudo service ssh start

fi

exec "$@"
