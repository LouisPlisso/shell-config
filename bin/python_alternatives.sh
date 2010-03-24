#!/bin/sh
# creates python alternatives with default as 2.6
# launch as sudoer

[ -h /etc/alternatives/python ] || ( update-alternatives --install /usr/bin/python python /usr/bin/python2.5 10; update-alternatives --install /usr/bin/python python /usr/bin/python2.6 20 )

update-alternatives --config python
