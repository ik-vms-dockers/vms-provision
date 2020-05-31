#!/bin/sh

set -e

: ${USER:-vagrant}
: ${PACKAGES:-build-essential}

ARCH="$(uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|')"

echo "Run in priveledged mode"

if [ $(id -u) -ne 0 ]; then
  echo "Please run as root" ;
  exit 1 ;
fi

export DEBIAN_PRIORITY=critical
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

APT_OPTS="--assume-yes --no-install-suggests --no-install-recommends -o Dpkg::Options::=\"--force-confdef\" \
  -o Dpkg::Options::=\"--force-confold\""

echo "upgrading packages ..."
apt-get update ${APT_OPTS}
apt-get dist-upgrade --assume-yes
echo "install packages ..."
apt-get install -qqy ${PACKAGES}
echo "install completed"
apt-get autoclean && apt-get autoremove -y && apt-get clean
echo "cleanup completed"
