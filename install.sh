#!/bin/bash

# retrieve full path of install dir: can be sourced or whatever but needs bash
# from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in
INSTALL_DIR="${BASH_SOURCE[0]}";
if([ -h "${INSTALL_DIR}" ]) then
  while([ -h "${INSTALL_DIR}" ]) do INSTALL_DIR=`readlink "${INSTALL_DIR}"`; done
fi
# to store dir where script was launched
#pushd . > /dev/null
cd `dirname ${INSTALL_DIR}` > /dev/null
INSTALL_DIR=`/bin/pwd`;

/bin/grep dvorak_prog /usr/share/X11/xkb/symbols/fr >> /dev/null && variant=dvorak_prog || variant=dvorak
printf "First sets %s keyboard layout\n" $variant
setxkbmap fr -variant $variant

echo "Install current user as sudoer"
/bin/sed "s/\<__USER__\>/${USER}/g" sudoers.template > sudoers.local
echo -n "Root passwd needed. "
/bin/su -c '/bin/cp -b --suffix='.old' sudoers.local /etc/sudoers; chown root:root /etc/sudoers; /bin/chmod 440 /etc/sudoers' && echo "Will not promt for sudoer passwd until end of install" || echo "Sudoer install failure: if user is not sudoer, only user's settings will be performed" 
/bin/rm sudoers.local
sudo /bin/sh -c 'grep "EDITOR=vi" /root/.bashrc > /dev/null || echo "EDITOR=vi" >> /root/.bashrc'

echo "Sets programmer dvorak-fr keyboard layout"
sudo /bin/cp -b --suffix='.old' fr /usr/share/X11/xkb/symbols/fr
setxkbmap fr -variant dvorak_prog

echo "Update sources.list"
sudo /bin/cp -b --suffix='.old' sources.list /etc/apt/sources.list
sudo /bin/sh bin/apt-get-ni.sh update
sudo /bin/sh bin/apt-get-ni.sh install debian-multimedia-keyring
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo /bin/sh bin/apt-get-ni.sh update
# non-interactive upgrade
sudo /bin/sh bin/apt-get-ni.sh dist-upgrade

echo "Installing selected packages"
/bin/cat aptitude_list | xargs -I {} sudo /bin/sh bin/apt-get-ni.sh install {}

echo "Configure DHCP"
sudo /bin/cp -b --suffix='.old' dhclient.conf /etc/dhcp3/dhclient.conf

echo "Configure netapp"
if /bin/chmod 000 smbcredentials; then
	sudo /bin/rm /root/.smbcredentials
	sudo /bin//bin/ln -s smbcredentials /root/.smbcredentials
fi
/bin/grep netapp /etc/fstab > /dev/null && echo "netapp already included in fstab" || sudo sh -c '/bin/cat fstab >> /etc/fstab'

echo "Configure printers"
sudo /bin/cp -b --suffix='.old' printers.conf /etc/cups/printers.conf

echo "Configure ktouch"
[ -e /usr/share/kde4/apps/ktouch/ ] && sudo /bin/cp -b --suffix='.old' dvorak-fr-1.ktouch.xml dvorak-fr-2.ktouch.xml /usr/share/kde4/apps/ktouch/

echo "Configure latex"
LATEX_DIR=/usr/share/texmf/tex/latex/
if [ -e $LATEX_DIR ]; then
    [ -h $LATEX_DIR ] && sudo /bin/rm $LATEX_DIR
    [ -f ${LATEX_DIR} ] && sudo /bin/mv ${LATEX_DIR} ${LATEX_DIR}.old 
    sudo /bin/ln -s ${INSTALL_DIR}/latex ${LATEX_DIR}/my_sty
fi

#TODO: xorg?

echo "Administrative part finished: no user with no passwd for all cmds"
sudo /bin/sed -i "/^[^#].*ALL=NOPASSWD: ALL/s/^/#/" /etc/sudoers

echo "Install config files"
[ -h ${HOME}/.bashrc ] && /bin/rm ${HOME}/.bashrc
[ -f ${HOME}/.bashrc ] && /bin/mv ${HOME}/.bashrc ${HOME}/.bashrc.old
/bin/sed "s,\<__INSTALL_DIR__\>,${INSTALL_DIR},g" bashrc.template > ${HOME}/.bashrc
for file in profile xmodmaprc xmodmaprc xsessionrc inputrc vimrc gvimrc; do
	TARGET=${HOME}/.$file 
	[ -h ${TARGET} ] && /bin/rm ${TARGET}
	[ -f ${TARGET} ] && /bin/mv ${TARGET} ${TARGET}.old || /bin/rm $TARGET 2> /dev/null
	/bin//bin/ln -s ${INSTALL_DIR}/$file ${TARGET}
done

echo "Configure awesome"
AWESOME_DIR=${HOME}/.config/awesome 
[ -h $AWESOME_DIR ] && /bin/rm $AWESOME_DIR
[ -f ${AWESOME_DIR} ] && /bin/mv ${AWESOME_DIR} ${AWESOME_DIR}.old || /bin/rm $AWESOME_DIR 2> /dev/null
/bin/ln -s ${INSTALL_DIR}/awesome $AWESOME_DIR 
for file in awesome/rc.lua awesome/theme.lua; do
    /bin/sed "s,\<__INSTALL_DIR__\>,${INSTALL_DIR},g" ${file}.template > $file
done

# to restore directory
#popd  > /dev/null
