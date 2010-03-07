#!/bin/sh

export DEBIAN_FRONTEND=non-interactive
apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options="--force-confold" $*
