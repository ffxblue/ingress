#!/usr/bin/env bash

cd /go/src/controllers/nginx

make container DOCKER="docker" PREFIX=${PREFIX}
