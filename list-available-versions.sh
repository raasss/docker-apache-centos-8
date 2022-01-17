#!/usr/bin/env bash

cd "$(dirname $0)"

docker run centos:8 bash -c "yum makecache && yum --showduplicates list available httpd"
