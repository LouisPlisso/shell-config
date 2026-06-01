# tmux config reference

Prefix: Ctrl+S.  Double-tap Ctrl+S to switch to last window.

---

## SESSIONS

    tmux new -s <name>      new named session
    tmux attach -t <name>   attach to session
    tmux ls                 list sessions
    prefix + $              rename session
    prefix + d              detach

---

## WINDOWS

    prefix + c              new window (inherits current path)
    prefix + ,              rename window
    prefix + n / p          next / previous window
    prefix + <n>            jump to window n
    prefix + Ctrl+S         switch to last window
    prefix + &              kill window

---

## PANES

    prefix + "              split horizontal (same path)
    prefix + %              split vertical (same path)
    prefix + x              kill pane

    Navigation — works seamlessly across vim splits and tmux panes:
    Ctrl+H / J / K / L     move left / down / up / right

    prefix + h / j / k / l same (when inside vim, use Ctrl variants)
    prefix + z              zoom pane (toggle fullscreen)
    prefix + q              show pane numbers
    prefix + {/}            swap pane left / right
    prefix + space          cycle pane layouts

---

## COPY MODE (vi)

    prefix + [              enter copy mode
    v                       begin selection
    y                       copy selection and exit
    prefix + ]              paste

    tmux-yank: y in copy mode also copies to system clipboard.
    On macOS uses pbcopy; on Linux uses xclip/xsel/wl-clipboard.

---

## RESURRECT

Save and restore sessions across reboots.

    prefix + a              save session
    prefix + r              restore session

    Vim sessions are also saved and restored
    (requires :mksession support — enabled by default).

---

## PLUGINS

Git submodules — available after install.sh, updated with:

    git submodule update --remote tmux/plugins/tmux-resurrect
    git submodule update --remote tmux/plugins/tmux-yank

    Active plugins:
      tmux-plugins/tmux-resurrect    session save/restore
      tmux-plugins/tmux-yank         system clipboard integration

---

## STATUS BAR

Solarized dark or light, chosen automatically:
- macOS: detects system dark/light mode at startup and re-checks every minute
  (picks up iTerm2 "follow the sun" switching within ~60 seconds)
- SSH / Linux: starts in dark mode; toggle manually with prefix+T

    prefix + t      toggle dark / light (or re-detect on macOS)

---

## MISC SETTINGS

    history-limit=10000     scrollback buffer
    base-index=0            windows and panes numbered from 0 (default)
    escape-time=1           near-zero ESC delay (important for vi mode)
    mouse=on                click to select pane/window, scroll to scroll
    monitor-activity=on     flag windows with activity in status bar
    renumber-windows=on     gaps in window numbers close automatically
