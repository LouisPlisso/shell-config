" Remove ALL auto-commands.  This avoids having the autocommands twice when
" the vimrc file is sourced again.
autocmd!

fun! MySys()
   return "$1"
endfun
set runtimepath=__INSTALL_DIR__/vim_runtime,__INSTALL_DIR__/vim_runtime/after,__INSTALL_DIR__/vim,\$VIMRUNTIME
source __INSTALL_DIR__/vim_runtime/vimrc
helptags __INSTALL_DIR__/vim_runtime/doc

source __INSTALL_DIR__/vim/vimrc

imap uu <Esc>
