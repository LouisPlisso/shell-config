#!/bin/sh
# launch as sudoer

[ -h /usr/bin/python ] && /bin/rm /usr/bin/python

/bin/ln -s /usr/bin/python2.5 /usr/bin/python
