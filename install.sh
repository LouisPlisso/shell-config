#!/bin/bash

# Resolve the directory this script lives in (works when called from any location)
INSTALL_DIR="${BASH_SOURCE[0]}"
while [ -h "${INSTALL_DIR}" ]; do INSTALL_DIR=$(readlink "${INSTALL_DIR}"); done
cd "$(dirname "${INSTALL_DIR}")" > /dev/null
INSTALL_DIR=$(pwd)

echo "==> Init git submodules (vim plugins, zsh plugins)"
git submodule update --init --recursive

echo "==> Generate dot files from templates"
for template in bashrc.template zshrc.template; do
    [ -f "${template}" ] || continue
    file=$(basename "${template}" .template)
    target="${HOME}/.${file}"
    [ -h "${target}" ] && rm "${target}"
    [ -f "${target}" ] && mv "${target}" "${target}.old"
    sed "s,__INSTALL_DIR__,${INSTALL_DIR},g" "${template}" > "${target}"
    echo "    ${target}"
done

echo "==> Symlink config files"
for file in profile inputrc vimrc gvimrc dircolors vim zsh gitconfig gitconfig.local ctags sqliterc; do
    [ -e "${INSTALL_DIR}/${file}" ] || continue
    target="${HOME}/.$(basename ${file})"
    [ -h "${target}" ] && rm "${target}"
    [ -f "${target}" ] && mv "${target}" "${target}.old"
    ln -s "${INSTALL_DIR}/${file}" "${target}"
    echo "    ${target} -> ${INSTALL_DIR}/${file}"
done

echo ""
echo "NOTE: on work machines without SSH keys, remove the gitconfig.local symlink:"
echo "    rm ~/.gitconfig.local"
echo "Submodule URLs use HTTPS so cloning still works without it."
echo ""
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "==> macOS: install recommended tools:"
    echo "    brew install fzf ripgrep universal-ctags"
    echo "    (zsh plugins are bundled as submodules)"
else
    echo "==> Linux: install recommended tools:"
    echo "    apt install fzf ripgrep universal-ctags zsh"
fi
