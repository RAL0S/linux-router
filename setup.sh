#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/garywill/linux-router/raw/9e1d985623e92a507c6eba93e0bfddb25e3e6f01/lnxrouter -O $RALPM_TMP_DIR/lnxrouter
  mv $RALPM_TMP_DIR/lnxrouter $RALPM_PKG_INSTALL_DIR/
  chmod +x $RALPM_PKG_INSTALL_DIR/lnxrouter
  ln -s $RALPM_PKG_INSTALL_DIR/lnxrouter $RALPM_PKG_BIN_DIR/
  echo "This package provides the following command:
  - lnxrouter
  
  Check https://github.com/garywill/linux-router for usage"
}

uninstall() {
  rm $RALPM_PKG_BIN_DIR/lnxrouter
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1