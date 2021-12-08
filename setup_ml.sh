#!/bin/sh

set -e

PIP3_BIN=/opt/ml/.pyenv/shims/pip3

setup_common() {
  apt-get update
  apt-get install -y curl sqlite3

  # pyenv
  apt-get install -y make build-essential libssl-dev zlib1g-dev \
          libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
          libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
          libffi-dev liblzma-dev git
  mkdir -p /opt/ml
  git clone https://github.com/pyenv/pyenv.git /opt/ml/.pyenv
  export PYENV_ROOT=/opt/ml/.pyenv
  /opt/ml/.pyenv/bin/pyenv install 3.7.3
  /opt/ml/.pyenv/bin/pyenv global 3.7.3
  chmod -R 777 /opt/ml
}

setup_data_collection_env() {
  if ! type "go" > /dev/null; then
    go_version=1.11.13
    curl -f -L -o go.tgz "https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz" && \
      tar -C /usr/local -xzf go.tgz && \
      rm go.tgz && \
      ln -s "/usr/local/go/bin/go" "/usr/local/bin/go"
    go version
  fi
}

setup_xgboost() {
  # cmake (xgboost needs latest cmake)
  curl -f -L -o "cmake.sh" "https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.sh"
  mkdir -p /opt/cmake
  yes | sh cmake.sh --prefix=/opt/cmake
  ln -s /opt/cmake/cmake-3.18.4-Linux-x86_64/bin/cmake /usr/local/bin/cmake

  "$PIP3_BIN" install scipy==1.7.3
  "$PIP3_BIN" install numpy==1.21.4
  "$PIP3_BIN" install xgboost==1.5.1

  rm -rf /opt/cmake/cmake-3.18.4-Linux-x86_64/bin/cmake /usr/local/bin/cmake
}

setup_stable_baselines() {
  apt-get install -y zlib1g-dev libjpeg-dev jq gfortran libopenblas-dev liblapack-dev
  "$PIP3_BIN" install stable_baselines3==1.3.0 sklearn psutil
}

setup_model_env() {
  setup_xgboost
  setup_stable_baselines
}

setup_common
setup_data_collection_env
setup_model_env
