#!/bin/sh

set -u

export BASE_URL=https://raw.githubusercontent.com/ik-vms-dockers/vms-provision

curl -L ${BASE_URL}/v0.0.2/ubuntu/001.install.sh | bash
