ARG RUNTIME
ARG VERSION
ARG USER='ssh-user'

FROM ${RUNTIME}:${VERSION}-slim
ARG USER

RUN apt-get update && apt-get install -y \
  openssh-server                         \
  gosu                                   \
  sudo                                   \
  && rm -rf /var/lib/apt/lists/*

RUN  adduser --disabled-password --gecos '' ${USER}                 \
  && gpasswd -a ${USER} sudo                                        \
  && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
  && ssh-keygen -A                                                  \
  && sed -i 's|#PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config

WORKDIR /opt/docker/entrypoints
COPY entrypoints/* .
RUN chown root:sudo *.sh && chmod ug+x *.sh

USER ${USER}
WORKDIR /home/${USER}

ENV ENABLE_SSH true
ENV SSH_PORT 22
ENTRYPOINT ["/opt/docker/entrypoints/openssh.sh"]
CMD ["bash"]

ONBUILD ENTRYPOINT ["/opt/docker/entrypoints/openssh-child.sh"]
