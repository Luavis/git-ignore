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
GIT_IGNORE_URL=https://raw.github.com/Luavis/git-ignore/master/git-ignore
GIT_EXISTS="$(where git)"
CURL_EXISTS="$(where git)"

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
  echo "please install git first"
fi

# check curl exists

if [[ $CURL_EXISTS = "git not found" ]]; then
  echo "please install curl first"
fi

##########################
# Start install
##########################
echo "Install git ignore binary"
# install in bin
curl -sL GIT_IGNORE_URL > $BIN_PATH/$GIT_IGNORE

echo "Install git ignore files"

# install git ignores
git clone https://github.com/github/gitignore $SHARE_PATH
