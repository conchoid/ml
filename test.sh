#!/bin/bash

set -e

#docker build . --file=Dockerfile.stretch.test
#docker build . --file=Dockerfile.buster.test
#docker build . --file=Dockerfile.bullseye.test
docker build . --file=Dockerfile.bookworm.test

