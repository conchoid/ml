#!/bin/sh

version="0.2.7"
docker build . --tag "conchoid/ml:${version}" && docker push "conchoid/ml:${version}"
