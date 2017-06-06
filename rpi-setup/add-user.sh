#!/bin/bash

#-----------------------------------------------------------------------
# Raspberry Pi 3
#
# add-user.sh - Add user
#
# usage: install-docker.sh
#
# Copyright (c) 2017 Takeshi Yonezu
# All Rights Reserved.
#-----------------------------------------------------------------------

logmsg() {
  echo ">>> $1"
}

if [ $(id -u) -ne 0 ]; then
  echo "*ERROR* $0 must run 'root' user."
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "Usage: $0 <user> [<comment>]"
  exit 1
fi

logmsg "Create $1 user account"

if [[ "$1" == "git" ]; then
  groupadd -g 1001 git
  useradd -g git -u 1001 -c "git Administrator" -m -d /var/git git
  passwd -l git

  chown git:git /var/git
  chmod 2775 /var/git

  apt -y install git

  echo "=== Firsttime you should exec below configuration ==="
  echo "$ git config --global user.name \"John Doe\""
  echo "$ git config --global user.email johndoe@example.com"
  echo "$ git config --global core.editor vi"
  echo "$ git config --global push.default simple"
else
  groupadd $1
  if [ $# -lt 2 ]; then
    useradd -m -g $1 $1
  else
    useradd -c "$2" -m -g $1 $1
  fi
fi

exit 0
