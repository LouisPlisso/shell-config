# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [[ "$OSTYPE" == "darwin"* ]]
then
    export MY_CONFIG_DIR=/Users/lplissonneau/config
else
    export MY_CONFIG_DIR=/home/ec2-user/_config
fi

export SHELL=/bin/zsh

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
    # include .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        . "$HOME/.zshrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    PATH="$HOME/bin:$PATH"
#fi

# missing dvorak_prog in console
#sudo loadkeys /usr/share/keymaps/i386/dvorak/dvorak-fr.kmap.gz

# done only if X so in xsessionrc
#setxkbmap fr -variant dvorak_prog || setxkbmap fr -variant dvorak

# export DOCKER_CERT_PATH=/Users/lplissonneau/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1


#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
