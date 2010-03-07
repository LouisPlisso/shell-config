" Remove ALL auto-commands.  This avoids having the autocommands twice when
" the vimrc file is sourced again.
autocmd!

fun! MySys()
   return "$1"
endfun
set runtimepath=$MY_CONFIG_DIR/vim_runtime,$MY_CONFIG_DIR/vim_runtime/after,$MY_CONFIG_DIR/vim,\$VIMRUNTIME
source $MY_CONFIG_DIR/vim_runtime/vimrc
helptags $MY_CONFIG_DIR/vim_runtime/doc

source $MY_CONFIG_DIR/vim/vimrc

imap uu <Esc>
