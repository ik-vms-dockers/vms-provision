#!/bin/sh

set -e

apt autoremove -y && apt clean
echo "cleanup completed"

history -c && history -w
