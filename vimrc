" Remove ALL auto-commands.  This avoids having the autocommands twice when
" the vimrc file is sourced again.
autocmd!

fun! MySys()
   return "$1"
endfun
set runtimepath=~/s-alois/vim_runtime,~/s-alois/vim_runtime/after,~/s-alois/vim,\$VIMRUNTIME
source ~/s-alois/vim_runtime/vimrc
helptags ~/s-alois/vim_runtime/doc

source ~/s-alois/vim/vimrc

imap uu <Esc>
