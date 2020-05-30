#!/bin/sh

set -e

: ${USER:-vagrant}
: ${PACKAGES:-build-essential}

ARCH="$(uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|')"

echo "Run in priveledged mode"

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

export DEBIAN_PRIORITY=critical
export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

APT_OPTS="--assume-yes --no-install-suggests --no-install-recommends -o Dpkg::Options::=\"--force-confdef\" \
  -o Dpkg::Options::=\"--force-confold\""

echo "adding repositories ..."
chown -R _apt:root /var/lib/apt/lists
echo "upgrading packages ..."
apt-get update ${APT_OPTS}
apt-get dist-upgrade --assume-yes
echo "install packages ..."
apt-get install -qqy ${PACKAGES}
echo "packages installed"
chown -R ${USER} /usr/local/bin
curl -L https://raw.githubusercontent.com/warrensbox/tgswitch/release/install.sh | bash
echo "install completed"
apt autoremove && apt clean
echo "cleanup completed"

ln -sfn  /usr/bin/python3 /usr/bin/python
