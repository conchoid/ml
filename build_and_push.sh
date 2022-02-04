#!/bin/sh

version="0.2.2"
docker build . --tag "conchoid/ml:${version}" && docker push "conchoid/ml:${version}"
