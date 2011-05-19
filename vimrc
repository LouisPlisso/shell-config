" Remove ALL auto-commands.  This avoids having the autocommands twice when
" the vimrc file is sourced again.
autocmd!
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

inoremap uu <Esc>

source $HOME/.vim/vimrc

