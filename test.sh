#!/bin/bash

set -e

docker build . --file=Dockerfile.stretch.test
docker build . --file=Dockerfile.buster.test

