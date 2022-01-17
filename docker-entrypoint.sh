# !/usr/bin/env bash

set -ex

rm -rvf /var/run/httpd/httpd.pid

exec /usr/sbin/httpd -DFOREGROUND
