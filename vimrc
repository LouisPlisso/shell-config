" Remove ALL auto-commands.  This avoids having the autocommands twice when
" the vimrc file is sourced again.
autocmd!

"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

fun! MySys()
   return "$1"
endfun
"set mainruntimepath=$MY_CONFIG_DIR/vim
"set runtimepath=$MY_CONFIG_DIR/vim,$MY_CONFIG_DIR/vim/after,$VIMRUNTIME

",$MY_CONFIG_DIR/vim_runtime
",$MY_CONFIG_DIR/vim_runtime/after
"helptags $MY_CONFIG_DIR/vim_runtime/doc

"source $MY_CONFIG_DIR/vim_runtime/vimrc
"source $MY_CONFIG_DIR/vim/vimrc

source $HOME/.vim/vimrc

imap uu <Esc>

