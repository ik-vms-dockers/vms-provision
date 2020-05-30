#!/bin/sh

set -ex

apt-get install -y git
/usr/bin/git config --system url."https://github.com/".insteadOf git@github.com:
/usr/bin/git config --system url."https://".insteadOf git://
