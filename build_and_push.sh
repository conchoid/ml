#!/bin/sh

version="0.1.1"
docker build . --tag "conchoid/ml:${version}" && docker push "conchoid/ml:${version}"