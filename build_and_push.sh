#!/bin/sh

version="0.2.3"
docker build . --tag "conchoid/ml:${version}" && docker push "conchoid/ml:${version}"
