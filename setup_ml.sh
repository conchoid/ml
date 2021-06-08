#!/bin/sh

set -e

setup() {
  apt-get update && apt-get install -y curl sqlite3

  if ! type "go" > /dev/null; then
    go_version=1.11.13
    curl -f -L -o go.tgz "https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz" && \
      tar -C /usr/local -xzf go.tgz && \
      rm go.tgz && \
      ln -s "/usr/local/go/bin/go" "/usr/local/bin/go"
    go version
  fi
}

install_xgboost() {
  # cmake (xgboost needs latest cmake)
  curl -f -L -o "cmake.sh" "https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.sh"
  mkdir -p /opt/cmake
  yes | sh cmake.sh --prefix=/opt/cmake
  ln -s /opt/cmake/cmake-3.18.4-Linux-x86_64/bin/cmake /usr/local/bin/cmake

  # python3, xgboost
  apt-get update
  apt-get install -y python3 python3-pip
  pip3 install xgboost
}

clean() {
  rm -rf /opt/cmake/cmake-3.18.4-Linux-x86_64/bin/cmake /usr/local/bin/cmake
}

setup
install_xgboost
clean
