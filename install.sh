#!/bin/bash

###########################################################################
#
# install.sh
# 
# git ignore install script
#
#
# @author Luavis.
# @date 2015.06.14
# @license MIT LICENSE
#
###########################################################################

GIT_IGNORE=git-ignore
BIN_PATH=/usr/bin
SHARE_PATH=/usr/share/git-ignore
GIT_IGNORE_URL=https://raw.github.com/Luavis/git-ignore/master/bin/git-ignore
GIT_EXISTS="$(where git)"
CURL_EXISTS="$(where curl)"

##########################
# check user permission
##########################
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root :(" 
    echo "Please try running this command again as root user"
    exit 1
fi

##########################
# check dependency
##########################
# check git exists

if [[ $GIT_EXISTS = "git not found" ]]; then
  echo "Please install git first"
  exit
fi

# check curl exists

if [[ $CURL_EXISTS = "git not found" ]]; then
  echo "Please install curl first"
  exit
fi

##########################
# Start install
##########################
echo "==================================="
echo "Install git ignore binary"
# install in bin
curl -sL GIT_IGNORE_URL > $BIN_PATH/$GIT_IGNORE

echo "Install git ignore files"

# install git ignores
git clone https://github.com/github/gitignore $SHARE_PATH

echo "Install finished"
echo "==================================="
