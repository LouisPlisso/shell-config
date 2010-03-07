die() {
    result=$1
    shift
    echo ": $*" >&2
    exit $result
}

[ -d $MY_CONFIG_DIR ] || die 1 "must have variable MY_CONFIG_DIR set"

export LESS="-R"
export EDITOR=vi
set -o vi

alias pysh='ipython -p pysh'
#alias print ‘lpr \!* -Pps5′


export PATH=$PATH:/sbin:${MY_CONFIG_DIR}/bin

# scripts from "Shell Scripting Recipes": http://shell.cfajohnson.com/ssr/ssr-scripts.tar.gz
[ -d $HOME/.scripts_recipes/bin ] && export PATH=$PATH:$HOME/.scripts_recipes/bin


export PYTHONPATH=~/workspace/spydump/tools

export XDG_CONFIG_HOME=${MY_CONFIG_DIR}

sudo loadkeys /usr/share/keymaps/i386/dvorak/dvorak-fr.kmap.gz

setxkbmap fr -variant dvorak_prog

# keep trace of installed packages (even tentatives)
sapti() {
        if [ sudo aptitude install $@ ]
	then
		# warning: will also store uninstalled packages
        	echo $@ >> ${MY_CONFIG_DIR}/aptitude_list_local
	fi
 }

saptr() {
        if [ sudo aptitude remove $@ ]
	then
        	for package in $*
        	do
                	sed -i "/^[^#]/s/\(\<$package\>\)[[:space:]]*/# &\n/g" ${MY_CONFIG_DIR}/aptitude_list_local
        	done
        	sed -i '/^$/d' ${MY_CONFIG_DIR}/aptitude_list_local
	fi
 }

