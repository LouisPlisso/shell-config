# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/louis/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
#HISTFILE=~/.histfile
#HISTSIZE=2000
#SAVEHIST=4000
setopt appendhistory beep extendedglob nomatch notify
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install


###################################################################
###################################################################
###################################################################
###################################################################
###################################################################
#my zsh

zstyle ':completion:*:scp:*' ignore-line yes
bindkey '^R' history-incremental-search-backward
bindkey '^?' backward-delete-char

###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

#prompt

#autoload -U colors && colors
#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#autoload -U promptinit
#promptinit
#prompt adam2


#from web
#. $MY_CONFIG_DIR/zsh_prompt
# From http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- COMMAND --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

#from axel


setupcon

# TTY char 8bits (accents)
stty pass8 -ixon

# local X session
#alias Xlocal='X -once -query $HOST'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
PAGER='less'
#EDITOR='emacs -nw'
# End of lines configured by zsh-newuser-install

# On charge les couleurs
 autoload -U colors
 colors
 # Définition des couleurs
 cn="%{$reset_color%}"  # normal color
 cc="%{$fg[grey]%}"     # command color
 cs="%{$fg[yellow]%}"   # symbol color
 cu="%{$fg[cyan]%}"     # user info color
 cr="%{$fg[gold]%}"    # root info color
 cd="%{$fg[blue]%}"     # directory color
 ce="%{$fg[red]%}"      # failed error color
 cf="%{$fg[magenta]%}"      # root name color
 cw="%{$fg[white]%}"

# Définition de 'PROMPT'
 # -------------------------

if [ "`id -u`" -eq 0 ]; then
export PS1="${cs}[${cw}%n${cs}@${cw}%m${cs}:${cw}%~${cs}]<${cf}!${cs}> ${cn}"
else
export PS1="${cs}[${cw}%n${cs}@${cw}%m${cs}:${cw}%~${cs}] ${cn}"
fi

 # %n : nom d'utilisateur
 # %m : nom de machine 

#if [ "`id -u`" -eq 0 ]; then
#export RPS1="${cs}<${cw}%T${cs}>${cn}"
#else
#export RPS1="${cs}<${cw}%T${cs}>${cn}"
#fi

# Alias 

#alias xterm='xterm -bg black -fg white'

# LS

export LS_OPTIONS='--color=auto'
eval `dircolors`
alias ls='ls --group-directories-first $LS_OPTIONS'
alias l1='ls -1'
alias lb='ls -shapC'
alias ll='ls -lh'
alias la='ls -Alh'
alias l='ls -CF'

#alias conkys='touch /home/limpare/.conky_show'
#alias conkyh='rm /home/limpare/.conky_show'
#alias tpoff='synclient TouchpadOff=1'
#alias tpon='synclient TouchpadOff=0'

#alias saveuh='/home/limpare/php/bin/php save.php .'


# Créer un répertoire et l'ouvrir :

alias mcd='mkdir \!*; cd \!*'

# Afficher le contenu d'un dossier .tar.gz, ou le décompresser :

#alias emacs_c='emacs *.c *.h'

alias lst='tar -tfz'
alias untar='tar -xfvz'
alias j='jobs -l'
alias h='history|more'
 
# Quelques alias pratiques
alias less='less --quiet'
alias df='df --human-readable'
alias du='du --human-readable'
#alias m='mutt -y'
#alias c='calcurse'
alias less='less -e -i -m -R'

# Pile de Répertoires
alias p='popd'

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
# setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
unsetopt list_ambiguous
# (Merci à Youri van Rietschoten de m'avoir donné l'info !)

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effaçé
# setopt auto_remove_slash

# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify

# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd

# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd

# Ignore les doublons dans la pile
setopt pushd_ignore_dups

# N'affiche pas la pile après un "pushd" ou "popd"
setopt no_pushd_silent

# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice

#Report  the  status  of background and suspended jobs
#before exiting a shell with job control
setopt check_jobs

#Utilise les raccourci Emacs 
#setopt emacs 

# envoie un "HUP" aux jobs qui tournent quand le shell se ferme
setopt hup

# Si l’on essaie d’aller vers un réperoire non
# absolu et introuvable, essayer en le préfixant par  ̃
setopt cd_able_vars

# Lister les différents choix d’un achèvement automatique
setopt auto_list

#Prevents aliases on the command line from being internally 
#substituted before completion is attempted.  The effect is 
#to make the alias a  distinct  command  for
#completion purposes.
setopt complete_aliases

# Essai de réduire la liste d'autocomplétion en affichant 
#des colonnes de tailles différentes
setopt list_packed


#
# 5. Complétion des options des commandes
#


autoload -U compinit
compinit

#
# 6. Variable d'environnement perso
#
#export PATH=$PATH:./:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin


#export PATH=/home/dpcl9191/linux/buildroot/output/staging/usr/bin:$PATH
#export ftp_proxy=http://p-goodway:3128/

















###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

#from bashrc

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lh='ll -h'

export LESS="-R"
export EDITOR=vi

# done by inputrc
#set -o vi

bindkey    "\e[7~"    beginning-of-line
bindkey    "\e[8~"    end-of-line
bindkey    "\e[3~"    delete-char



alias 'cd..'='cd ..'
alias pysh='ipython -p pysh'
#alias print 'lpr \!* -Pps5'
alias saptu='sudo aptitude update'
alias saptdu='sudo aptitude dist-upgrade'
export PYTHONPATH=~/workspace/spydump/tools

# scripts from "Shell Scripting Recipes": http://shell.cfajohnson.com/ssr/ssr-scripts.tar.gz
SCRIPT_RECIPES=$HOME/.scripts_recipes/bin
[ -d $SCRIPT_RECIPES ] && export PATH=$PATH:$SCRIPT_RECIPES

# quicksnips: http://quicksnips.org/
QUICKSNIPS=$HOME/quicksnips/bin
[ -d $QUICKSNIPS ] && export PATH=$PATH:$QUICKSNIPS

# done in profile and xsessionrc
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



###################################################################
###################################################################
###################################################################
###################################################################
###################################################################

### vim:ft=zsh:
### VI MODE EXTENSIONS
### you might want to use these keybindings as well:
bindkey -v
bindkey -M vicmd "^R" redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "ga" what-cursor-position

### I've setup a multiline $PROMPT that contains the "--INSERT--" in the correct place.
### You might want to add something similar. Here is a skeleton:
### PROMPT="--INSERT--
### ----------
### %n@%m%~> "


#redisplay() {
#   builtin zle .redisplay
#   L=$[LINES - 1]
#   echo -n $'\e['"$L;0;H"
#   ( true ; show_mode "INSERT") &!
#}
#redisplay2() {
#   builtin zle .redisplay
#   L=$[LINES - 1]
#   echo -n $'\e['"$L;0;H"
#   (true ; show_mode "NORMAL") &!
#}
#zle -N redisplay
#zle -N redisplay2
bindkey -M viins "^X^R" redisplay
bindkey -M vicmd "^X^R" redisplay2

#screenclear () {
#   echo -n $'\e[2J\e[400H'
##repeat $[LINES - 2] echo
#   builtin zle .redisplay
##   builtin zle .clear-screen
#   (true ; show_mode "INSERT") &!
#}
#zle -N screenclear
#bindkey "^L" screenclear




show_mode() {
   local COL
   local x
   COL=$[COLUMNS-3]
   COL=$[COL-$#1]
   #x=$(wc -l $PREBUFFER)
   x=$(echo $PREBUFFER | wc -l )
   x=$[x+1]
#   echo -n $'\e7\e[0;'"$COL;H"
   echo -n $'\e7\e['"$x"$';A\e[0;G'
   echo -n ""
#    c='`'
#    echo -n $'\e7\e[5A\e[0'"$c"
   echo -n $'\e[0;37;44m'"--$1--"$'\e[0m'
   echo -n $'\e8'
}

###       vi-add-eol (unbound) (A) (unbound)
###              Move  to the end of the line and enter insert mode.

vi-add-eol() {
#   show_mode "INSERT"
   builtin zle .vi-add-eol
}
zle -N vi-add-eol
bindkey -M vicmd "A" vi-add-eol

###       vi-add-next (unbound) (a) (unbound)
###              Enter insert mode after the  current  cursor  posi­
###              tion, without changing lines.

vi-add-next() {
#   show_mode "INSERT"
   builtin zle .vi-add-next
   # OLDLBUFFER=$LBUFFER
   # OLDRBUFFER=$RBUFFER
   # NNUMERIC=$NUMERIC
   # bindkey -M viins $'\e' vi-cmd-mode-a
}
zle -N vi-add-next
bindkey -M vicmd "a" vi-add-next

#vi-cmd-mode-a() {
#   show_mode "NORMAL"
#   STRING="LLBUFFER=\${LBUFFER:s/$OLDLBUFFER//}"
#   eval $STRING
#   STRING="RRBUFFER=\${RBUFFER:s/$OLDRBUFFER/}"
#   eval $STRING
#   INS="$LLBUFFER$RRBUFFER"
#   LBUFFER=$OLDLBUFFER
#   repeat $NNUMERIC LBUFFER="$LBUFFER$INS"
#   builtin zle .vi-cmd-mode
#   unset LLBUFFER RRBUFFER NNUMERIC INS
#   bindkey -M viins $'\e' vi-cmd-mode
#}
#zle -N vi-cmd-mode-a

###       vi-change (unbound) (c) (unbound)
###              Read a movement command from the keyboard, and kill
###              from  the  cursor  position  to the endpoint of the
###              movement.  Then enter insert mode.  If the  command
###              is vi-change, change the current line.

vi-change() {
#   show_mode "INSERT"
   builtin zle .vi-change
}
zle -N vi-change
bindkey -M vicmd "c" vi-change

###       vi-change-eol (unbound) (C) (unbound)
###              Kill  to the end of the line and enter insert mode.

vi-change-eol() {
#   show_mode "INSERT"
   builtin zle .vi-change-eol
}
zle -N vi-change-eol
bindkey -M vicmd "C" vi-change-eol

###       vi-change-whole-line (unbound) (S) (unbound)
###              Kill the current line and enter insert mode.

vi-change-whole-line() {
#   show_mode "INSERT"
   builtin zle .vi-change-whole-line
}
zle -N vi-change-whole-line
bindkey -M vicmd "S" vi-change-whole-line

###       vi-insert (unbound) (i) (unbound)
###              Enter insert mode.

vi-insert() {
#   show_mode "INSERT"
   builtin zle .vi-insert
}
zle -N vi-insert
bindkey -M vicmd "i" vi-insert

###       vi-insert-bol (unbound) (I) (unbound)
###              Move to the first non-blank character on  the  line
###              and enter insert mode.

vi-insert-bol() {
#   show_mode "INSERT"
   builtin zle .vi-insert-bol
}
zle -N vi-insert-bol
bindkey -M vicmd "I" vi-insert-bol

###       vi-open-line-above (unbound) (O) (unbound)
###              Open a line above the cursor and enter insert mode.

vi-open-line-above() {
#   show_mode "INSERT"
   builtin zle .vi-open-line-above
}
zle -N vi-open-line-above
bindkey -M vicmd "O" vi-open-line-above

###       vi-open-line-below (unbound) (o) (unbound)
###              Open a line below the cursor and enter insert mode.

vi-open-line-below() {
#   show_mode "INSERT"
   builtin zle .vi-open-line-below
}
zle -N vi-open-line-below
bindkey -M vicmd "o" vi-open-line-below

###       vi-substitute (unbound) (s) (unbound)
###              Substitute the next character(s).

vi-substitute() {
#   show_mode "INSERT"
   builtin zle .vi-substitute
}
zle -N vi-substitute
bindkey -M vicmd "s" vi-substitute


###       vi-replace (unbound) (R) (unbound)
###              Enter overwrite mode.
###

vi-replace() {
#   show_mode "REPLACE"
   builtin zle .vi-replace
}
zle -N vi-replace
bindkey -M vicmd "R" vi-replace

###       vi-cmd-mode (^X^V) (unbound) (^[)
###              Enter  command  mode;  that  is, select the `vicmd'
###              keymap.  Yes, this is bound  by  default  in  emacs
###              mode.

vi-cmd-mode() {
#   show_mode "NORMAL"
   builtin zle .vi-cmd-mode
}
zle -N vi-cmd-mode
bindkey -M viins $'\e' vi-cmd-mode



###       vi-oper-swap-case
###              Read a movement command from the keyboard, and swap
###              the case of all characters from the cursor position
###              to the endpoint of the movement.  If  the  movement
###              command  is vi-oper-swap-case, swap the case of all
###              characters on the current line.
###

bindkey -M vicmd "g~" vi-oper-swap-case

