# shell-config

Personal config for zsh, tmux, and shell aliases. Works on macOS and Linux.
Vim config lives in the `vim/` submodule ([vim-config](https://github.com/LouisPlisso/vim-config)).

## Install

```sh
git clone https://github.com/LouisPlisso/shell-config.git ~/_config
cd ~/_config && bash install.sh
```

On macOS, install recommended tools:

```sh
brew install fzf ripgrep universal-ctags tmux
```

On Linux:

```sh
apt install fzf ripgrep universal-ctags zsh tmux
```

## What install.sh does

- Initialises all git submodules (vim plugins, zsh plugins, tmux plugins)
- Generates `~/.zshrc` and `~/.bashrc` from templates
- Symlinks config files into `~`:

| Symlink | Source |
|---------|--------|
| `~/.vim` | `vim/` |
| `~/.tmux` | `tmux/` |
| `~/.zsh` | `zsh/` |
| `~/.gitconfig` | `gitconfig` |
| `~/.tmux.conf` | `tmux.conf` |
| `~/.ctags` | `ctags` |
| ... | ... |

### SSH key handling

`gitconfig.local` rewrites GitHub HTTPS URLs to SSH — useful on personal machines
where your key is available. On work machines without a key, remove the symlink:

```sh
rm ~/.gitconfig.local
```

Submodule URLs use HTTPS so cloning always works either way.

## Reference docs

- [ZSHRC.md](ZSHRC.md) — zsh keybindings, vi mode, plugins, aliases
- [TMUX.md](TMUX.md) — tmux keybindings, resurrect, theme
- [vim/PLUGINS.md](vim/PLUGINS.md) — vim plugin reference
- [vim/VIMRC.md](vim/VIMRC.md) — vimrc settings and mappings
