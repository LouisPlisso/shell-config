#!/bin/bash

# retrieve full path
# from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-in
SCRIPT_PATH="${BASH_SOURCE[0]}";
if([ -h "${SCRIPT_PATH}" ]) then
  while([ -h "${SCRIPT_PATH}" ]) do SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
# to store dir where script was launched
#pushd . > /dev/null
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;

# customised config files will be there
mkdir local
LOCAL_INSTALL_DIR=${SCRIPT_PATH}/local

echo "First sets dvorak-fr keyboard layout or programmers dvorak-fr if available"
grep dvorak_prog /usr/share/X11/xkb/symbols/fr >> /dev/null && variant=dvorak_prog || variant=dvorak
setxkbmap fr -variant $variant

echo "Install current user as sudoer"
sed "s/__USER__/${USERNAME}/g" sudoers > local/sudoers
echo "Root passwd needed"
su -c 'cp local/sudoers /etc/sudoers; chown root:root /etc/sudoers; chmod 440 /etc/sudoers' && echo "Will not promt for sudoer passwd until end of install" || echo "Sudoer install failure: if user is not sudoer, only user's settings will be performed" 

echo "Sets programmer dvorak-fr keyboard layout"
sudo cp -b --suffix='.old' fr /usr/share/X11/xkb/symbols/fr
setxkbmap fr -variant dvorak_prog

echo "Changing sources.list"
sudo cp -b --suffix='.old' sources.list /etc/apt/sources.list
sudo aptitude update
sudo apt-get -y --force-yes install debian-multimedia-keyring
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo aptitude update
sudo aptitude dist-upgrade

echo "Installing selected packages"
cat aptitude_list | xargs -I {} sudo aptitude --assume-yes install {}

echo "Configure DHCP"
sudo cp -b --suffix='.old' dhclient.conf /etc/dhcp3/dhclient.conf

echo "Configure netapp"
sudo /bin/rm /root/.smbcredentials
sudo ln -s ${SCRIPT_PATH}/smbcredentials /root/.smbcredentials
grep netapp /etc/fstab > /dev/null && echo "netapp already included in fstab" || sudo cat fstab >> /etc/fstab

echo "Configure printers"
sudo cp -b --suffix='.old' printers.conf /etc/cups/printers.conf

echo "Configure ktouch"
[ -e /usr/share/kde4/apps/ktouch/ ] && sudo cp -b --suffix='.old' dvorak-fr-1.ktouch.xml dvorak-fr-2.ktouch.xml /usr/share/kde4/apps/ktouch/

#TODO: xorg?

sudo sed -i "/^[^#].*${USERNAME}.*ALL=NOPASSWD: ALL/s/^/#/" /etc/sudoers

echo "Installing config files"
mkdir -p ${LOCAL_INSTALL_DIR}/awesome ${HOME}/.config/awesome
for file in bashrc profile xmodmaprc xmodmaprc xsessionrc inputrc vimrc gvimrc awesome/rc.lua awesome/theme.lua
do
	sed "s/__INSTALL_DIR__/${SCRIPT_PATH}/g" $file > ${LOCAL_INSTALL_DIR}/$file
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
