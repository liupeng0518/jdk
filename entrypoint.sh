#!/bin/bash

# git conf
echo 'echo $GIT_TOKEN' > /tmp/.git-askpass
chmod +x /tmp/.git-askpass
git config --global credential.helper cache
git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_USER_EMAL}"
git config --global user.password "${GIT_TOKEN}"

# change branch
if [ -z $GIT_BRANCH ]; then
GIT_BRANCH='master'
fi

cd /home/coder/project
if [ ! -d ".git" ];then
  git clone http://${GIT_USER}@${GIT_ADDRESS}.git -b ${GIT_BRANCH} .
fi

# test git
git push

# start vscode
dumb-init fixuid -q /usr/bin/code-server --auth none --bind-addr 0.0.0.0:8080 /home/coder/project
