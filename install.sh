#!/bin/bash

# retrieve full path of install dir
# from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in
INSTALL_DIR="${BASH_SOURCE[0]}";
if([ -h "${INSTALL_DIR}" ]) then
  while([ -h "${INSTALL_DIR}" ]) do INSTALL_DIR=`readlink "${INSTALL_DIR}"`; done
fi
# to store dir where script was launched
#pushd . > /dev/null
cd `dirname ${INSTALL_DIR}` > /dev/null
INSTALL_DIR=`pwd`;

echo "First sets dvorak-fr keyboard layout or programmers dvorak-fr if available"
grep dvorak_prog /usr/share/X11/xkb/symbols/fr >> /dev/null && variant=dvorak_prog || variant=dvorak
setxkbmap fr -variant $variant

echo "Install current user as sudoer"
sed "s/__USER__/${USERNAME}/g" sudoers.template > sudoers.local
echo "Root passwd needed"
su -c 'cp sudoers.local /etc/sudoers; chown root:root /etc/sudoers; chmod 440 /etc/sudoers' && echo "Will not promt for sudoer passwd until end of install" || echo "Sudoer install failure: if user is not sudoer, only user's settings will be performed" 

echo "Sets programmer dvorak-fr keyboard layout"
sudo cp -b --suffix='.old' fr /usr/share/X11/xkb/symbols/fr
setxkbmap fr -variant dvorak_prog

echo "Update sources.list"
sudo cp -b --suffix='.old' sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y --force-yes install debian-multimedia-keyring
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
# non-interactive upgrade
export DEBIAN-FRONTEND=non-interactive
yes '' | sudo apt-get -y --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options="--force-confold" dist-upgrade

echo "Installing selected packages"
cat aptitude_list | xargs -I {} sudo aptitude --assume-yes install {}

echo "Configure DHCP"
sudo cp -b --suffix='.old' dhclient.conf /etc/dhcp3/dhclient.conf

echo "Configure netapp"
sudo /bin/rm /root/.smbcredentials
sudo ln -s ${INSTALL_DIR}/smbcredentials /root/.smbcredentials
grep netapp /etc/fstab > /dev/null && echo "netapp already included in fstab" || sudo cat fstab >> /etc/fstab

echo "Configure printers"
sudo cp -b --suffix='.old' printers.conf /etc/cups/printers.conf

echo "Configure ktouch"
[ -e /usr/share/kde4/apps/ktouch/ ] && sudo cp -b --suffix='.old' dvorak-fr-1.ktouch.xml dvorak-fr-2.ktouch.xml /usr/share/kde4/apps/ktouch/

#TODO: xorg?

sudo sed -i "/^[^#].*${USERNAME}.*ALL=NOPASSWD: ALL/s/^/#/" /etc/sudoers

echo "Installing config files"
sed "s/__INSTALL_DIR__/${INSTALL_DIR}/g" bashrc > bashrc.local
mkdir -p ${LOCAL_INSTALL_DIR}/awesome ${HOME}/.config/awesome
for file in bashrc.local profile xmodmaprc xmodmaprc xsessionrc inputrc vimrc gvimrc awesome/rc.lua awesome/theme.lua
do
	if grep awesome > /dev/null <<< $file
	then
		TARGET=$HOME/.config/$file
	else
		TARGET=$HOME/.$file 
	fi
	[ -e ${TARGET} ] && /bin/mv ${TARGET} ${TARGET}.old
	ln -s ${LOCAL_INSTALL_DIR}/$file ${TARGET}
done

# to restore directory
#popd  > /dev/null
