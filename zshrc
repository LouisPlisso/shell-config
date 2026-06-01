# zsh configuration — see ZSHRC.md for a full reference.

# --- Bootstrap ---

die() {
    local result=$1; shift
    echo ": $*" >&2
    exit "$result"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    export MY_CONFIG_DIR=/Users/$USER/_config
else
    export MY_CONFIG_DIR=/home/$USER/_config
fi

[ -d "$MY_CONFIG_DIR" ] || die 1 "MY_CONFIG_DIR ($MY_CONFIG_DIR) does not exist"
[ -f "$MY_CONFIG_DIR/shell_aliases_functions" ] && . "$MY_CONFIG_DIR/shell_aliases_functions"

# --- Vi mode ---
# Starts every prompt in insert mode. ESC switches to command mode.
# KEYTIMEOUT=1: 10ms ESC delay so mode switches feel instant.

bindkey -v
export KEYTIMEOUT=1

bindkey '^@' insert-last-word      # Ctrl+Space: insert last word of previous command
bindkey '^?' backward-delete-char
bindkey '^A'  beginning-of-line
bindkey '^E'  end-of-line

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line   # open command line in $EDITOR

bindkey -M vicmd '^R' redo
bindkey -M vicmd 'u'  undo
bindkey -M vicmd 'ga' what-cursor-position
bindkey -M vicmd 'g~' vi-oper-swap-case

# Home/End/Delete codes sent by some terminal emulators
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[3~" delete-char

# --- INSERT / COMMAND indicator in right prompt ---
# zle-keymap-select fires on every mode switch; zle-line-init fires on each
# new prompt so the indicator always starts as INSERT.
# RPS1 auto-hides when the terminal is too narrow — no special code needed.

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- COMMAND --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Clear the indicator when Enter is pressed so it doesn't appear in copied output
zle-line-finish() { RPS1=''; RPS2=''; zle reset-prompt; }
zle -N zle-line-finish

# Ctrl+R history search is handled by fzf (loaded at the bottom)

# --- History ---

SAVEHIST=30000
setopt hist_ignore_dups share_history inc_append_history extended_history hist_verify

# --- Completion ---

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:scp:*' ignore-line yes

setopt complete_aliases auto_list list_packed

# --- Directory navigation ---

setopt auto_cd auto_pushd pushd_ignore_dups no_pushd_silent pushd_to_home chase_links

# --- Shell behaviour ---

setopt correct hist_verify prompt_bang check_jobs dvorak
unsetopt beep hist_beep list_beep bg_nice hup glob_dots

# --- Prompt ---

autoload -U colors && colors

_cn="%{$reset_color%}"
_cc="%{$fg[gray]%}"
_cs="%{$fg[yellow]%}"
_cw="%{$fg[blue]%}"
_ce="%{$fg[red]%}"
_cf="%{$fg[magenta]%}"

if [ "$(id -u)" -eq 0 ]; then
    export PS1="${_cs}[${_cw}%n${_cs}@${_cw}%m${_cs}:${_cw}%~${_cs}]<${_cf}!${_cs}> ${_cn}"
else
    # %(3~|…/%2~|%~): show last 2 path components when deeper than 3 dirs
    export PS1="${_cc}[${_cw}%n${_cs}@${_cw}%m${_ce}:${_cs}%(3~|…/%2~|%~)${_cn}] "
fi

unset _cn _cc _cs _cw _ce _cf

# --- macOS PATH ---

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Detect Homebrew prefix (Apple Silicon: /opt/homebrew, Intel: /usr/local)
    _brew=/opt/homebrew
    [[ -d $_brew ]] || _brew=/usr/local
    [[ -d "$_brew/opt/python/libexec/bin" ]] && export PATH="$_brew/opt/python/libexec/bin:$PATH"
    [[ -d "$_brew/opt/coreutils/libexec/gnubin" ]] && export PATH="$_brew/opt/coreutils/libexec/gnubin:$PATH"
    unset _brew
fi

# --- Go ---

export GOPATH="${HOME}/go"
export GO111MODULE=on
export GOFLAGS="-mod=vendor"
export PATH="${PATH}:${GOPATH}/bin"

# --- Node (n version manager) ---

export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# --- pyenv ---

if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi

# --- kubectl ---

alias k=kubectl
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
    compdef k=kubectl
fi

# --- fzf ---
# Sets up Ctrl+T (file), Ctrl+R (history), Alt+C (cd). Requires fzf 0.48+.

if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
    # Alt+C fuzzy-cd is unreliable in vi mode on macOS (ESC+C clashes with
    # command mode). Use cd **<Tab> for fuzzy directory completion instead.
    bindkey -r '\ec'
fi

# --- GPG (commit signing) ---

export GPG_TTY=$(tty)

# XDG: point apps (bat, etc.) at the config dir instead of ~/.config
export XDG_CONFIG_HOME=${MY_CONFIG_DIR}

# --- Optional plugins (install via brew) ---
# brew install zsh-autosuggestions   → fish-like inline history suggestions
# brew install zsh-syntax-highlighting → color commands as you type

# zsh-autosuggestions: visible grey; suggestions come from history then completion.
# Right arrow is NOT bound to accept — it keeps its normal cursor-movement role.
# Use Ctrl+F to accept the full suggestion, or End to accept and jump to line end.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(forward-char vi-forward-char end-of-line vi-end-of-line vi-add-eol)

for _f in ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh \
           /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
           /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
    [ -f "$_f" ] && { source "$_f"; break; }
done

# Ctrl+F: accept full suggestion (bound after plugin is loaded so widget exists)
bindkey '^F' autosuggest-accept

# zsh-syntax-highlighting must be sourced last
for _f in ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
           /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
           /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
    [ -f "$_f" ] && { source "$_f"; break; }
done

unset _f
