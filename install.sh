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
GIT_EXISTS="$(whereis git)"
CURL_EXISTS="$(whereis curl)"

print_bold() {
  printf "\033[1m$1\033[0m"
}

echo_bold() {
  printf "\033[1m$1\033[0m\n"
}

echo_err() {
  printf "\033[0;31m$1\033[0m\n"
}

##########################
# check user permission
##########################
if [[ $EUID -ne 0 ]]; then
    echo_err "This script must be run as root :(" 
    echo_err "Please try running this command again as root user"
    exit 1
fi

##########################
# check dependency
##########################
# check git exists

if [[ $GIT_EXISTS = "git not found" ]]; then
  echo_err "Please install git first"
  exit 1
fi

# check curl exists

if [[ $CURL_EXISTS = "git not found" ]]; then
  echo_err "Please install curl first"
  exit 1
fi

##########################
# Start install
##########################
echo "==================================="

echo "Start Installing..."
echo 
echo_bold "\t* Installing git ignore binary"

if [[ -f $BIN_PATH/$GIT_IGNORE ]]; then # remove git ignore
  echo_bold "\t  Remove present git-ignore"
  rm -f $BIN_PATH/$GIT_IGNORE
fi

# install in bin
curl -sL $GIT_IGNORE_URL > $BIN_PATH/$GIT_IGNORE

printf "\t  Change git ignore permission as excutable\n"

# change permission
chmod 755 $BIN_PATH/$GIT_IGNORE

echo

echo_bold "\t* Installing git ignore files"

if [[ -d $SHARE_PATH ]]; then
  echo_bold "\t  Remove present github's gitignores"
  rm -rf $SHARE_PATH
fi

# install git ignores
git clone https://github.com/github/gitignore $SHARE_PATH &>/dev/null

echo 

echo_bold "Install finished"

echo 
echo "==================================="
