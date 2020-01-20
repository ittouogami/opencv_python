#!/bin/bash
USER=${USER:-root}
USER_ID=${LOCAL_UID:-1000}
GROUP_ID=${LOCAL_GID:-1000}
echo "Starting with UID : $USER_ID, GID: $GROUP_ID,USER: $USER"
if [[ -n "$USER_ID" ]]; then
  export HOME=/home/$USER
  useradd -s /bin/bash -u $USER_ID -o -d $HOME $USER
  usermod -aG sudo $USER
  echo root:root |chpasswd
  echo ${USER}:${USER} |chpasswd
  chown $USER_ID:$GROUP_ID -R $HOME
  #chown $USER_ID:$GROUP_ID -R /opt
  chown $USER $(tty)
  exec /usr/sbin/gosu "$USER" "$@"
else
  exec "$@"
fi

