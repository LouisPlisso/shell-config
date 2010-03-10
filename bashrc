############################################################################
# default config file parametrised
############################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lh='ll -h'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


############################################################################
# personized config
############################################################################



export LESS="-R"
export EDITOR=vi
# test vs inputrc
#set -o vi

alias pysh='ipython -p pysh'
#alias print 'lpr \!* -Pps5'
alias saptu='sudo aptitude update'
alias saptdu='sudo aptitude dist-upgrade'
export PYTHONPATH=~/workspace/spydump/tools

# scripts from "Shell Scripting Recipes": http://shell.cfajohnson.com/ssr/ssr-scripts.tar.gz
[ -d $HOME/.scripts_recipes/bin ] && export PATH=$PATH:$HOME/.scripts_recipes/bin

# sudo loadkeys /usr/share/keymaps/i386/dvorak/dvorak-fr.kmap.gz

# warning: xkbmap resets xmodmap
#setxkbmap fr -variant dvorak_prog
#setxkbmap us

die() {
    result=$1
    shift
    echo ": $*" >&2
    exit $result
}

[ -d $MY_CONFIG_DIR ] || die 1 "must have variable MY_CONFIG_DIR set"

alias cdc='cd $MY_CONFIG_DIR'

export PATH=$PATH:/sbin:${MY_CONFIG_DIR}/bin

# load FTRD config
. ${MY_CONFIG_DIR}/ftrd_config

# export VIMRUNTIME=${MY_CONFIG_DIR}/vim
export XDG_CONFIG_HOME=${MY_CONFIG_DIR}


# keep trace of installed packages (even tentatives)
sapti() {
        if sudo aptitude install $@
	then
		# warning: will also store uninstalled packages
        	echo $@ >> ${MY_CONFIG_DIR}/aptitude_list_local
	fi
 }

saptr() {
        if sudo aptitude remove $@
	then
        	for package in $*
        	do
                	sed -i "/^[^#]/s/\(\<$package\>\)[[:space:]]*/# &\n/g" ${MY_CONFIG_DIR}/aptitude_list_local
        	done
        	sed -i '/^$/d' ${MY_CONFIG_DIR}/aptitude_list_local
	fi
 }

