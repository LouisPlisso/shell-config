# zsh config reference

Config is split across two files:
  zshrc                  — zsh-only settings (vi mode, completion, prompt, tools)
  shell_aliases_functions — bash+zsh compatible aliases, functions, environment

---

## VI MODE

Every new prompt starts in INSERT mode. ESC enters COMMAND mode.

    Right prompt shows:   -- INSERT --   or   -- COMMAND --
    Auto-hides when terminal is too narrow (native RPS1 behaviour).

    KEYTIMEOUT=1: ESC registers in 10ms — mode switches feel instant.

Key bindings:

    Ctrl+Space      insert last word of previous command
    Ctrl+R          search history backward (incremental, pattern)
    Ctrl+S          search history forward
    Ctrl+A          beginning of line
    Ctrl+E          end of line

    --- In COMMAND mode (after ESC) ---
    v               open current line in $EDITOR
    u               undo
    Ctrl+R          redo
    g~              swap case (motion)
    ga              show character info at cursor

---

## PROMPT

Normal user:
    [user@host:path] 
    Path is truncated to the last 2 components when deeper than 3 directories:
    /a/b/c/d/e  →  […/d/e]

Root:
    [user@host:path]<!> 
    (full path, magenta !)

---

## HISTORY

    HISTSIZE / SAVEHIST: 30 000 entries
    share_history:        all open shells share the same history file
    inc_append_history:   each command appended immediately (not on exit)
    extended_history:     timestamps stored with each entry
    hist_ignore_dups:     consecutive duplicates not stored
    hist_verify:          ! expansion shown for confirmation before running

---

## COMPLETION

    Tab         cycle through menu (arrow keys to navigate)
    Enter       accept selection

    Case-insensitive matching (lower ↔ upper).
    complete_aliases: aliases are completed as distinct commands.
    Completion for scp ignores files already on the line.

---

## DIRECTORY NAVIGATION

    auto_cd         type a directory name to cd into it
    auto_pushd      cd pushes the old dir onto the directory stack
    pushd_ignore_dups  no duplicates in the stack
    pushd_to_home   bare pushd goes to $HOME

    The directory stack lets you navigate back with popd.

---

## SHELL OPTIONS

    correct         suggest corrections for mistyped commands
    prompt_bang     enable ! history expansion in the prompt
    dvorak          dvorak-aware key ordering for completions
    noglobalrcs     skip /etc/zprofile and /etc/zshrc
                    (PATH and other system settings are managed explicitly)

---

## TOOL INTEGRATIONS

### fzf
    Ctrl+T          fuzzy file search (insert path at cursor)
    Ctrl+R          fuzzy history search
    cd **<Tab>      fuzzy directory completion (Alt+C removed: clashes with
                    vi command mode on macOS)

    Install: brew install fzf  /  apt install fzf
    Requires fzf 0.48+ (June 2023).

### pyenv
    Loaded automatically if pyenv is on PATH.
    Manages Python versions per-project via .python-version files.

### Go
    GOPATH=$HOME/go
    GO111MODULE=on
    GOFLAGS=-mod=vendor    (all go commands use vendor/ by default)

### Node (n)
    N_PREFIX=$HOME/.n
    Manages Node versions with the n tool.

### kubectl
    k               alias for kubectl
    Tab completion active when kubectl is on PATH.

---

## PLUGINS

Bundled as git submodules in _config/zsh/ — available automatically after
install.sh. No brew or apt install needed.

zsh-autosuggestions: shows a greyed-out suggestion as you type.
    Right arrow  accept full suggestion (or move cursor if mid-line)
    Ctrl+F       accept full suggestion
    End          accept full suggestion and jump to end of line
    Suggestions come from completion first, then history.

zsh-syntax-highlighting: colors commands as you type — green for valid
commands, red for unknown ones.

---

## ALIASES AND FUNCTIONS

Defined in shell_aliases_functions. Key ones:

    ls / l / ll / la / lt   ls with colour; lt sorted by time
    grep                    always with --color=auto
    find                    wraps /usr/bin/find; excludes *~ backup files
    fj / fgo / fp / fr      find Java / Go / Python / Ruby files
    mcd <dir>               mkdir -p + cd in one step
    superman <topic>        man with web search fallback
    manswitch <cmd> <flag>  jump to a specific flag in a man page
    cdc                     cd to $MY_CONFIG_DIR
    sqlite                  alias for sqlite3
    pyprofile               python -m cProfile -s time
    gl                      git log graph with relative dates
    gst / gd / gdp / gch    git status / diff / diff HEAD^ / checkout
    gco                     git commit -a

---

## ENVIRONMENT

    EDITOR=vi
    PAGER=less
    LESS=-F -X -R    (quit if one screen, no clear on exit, colour support)
    HISTFILE=~/.histfile
    MY_CONFIG_DIR    set to /Users/$USER/_config (mac) or /home/$USER/_config
    GPG_TTY          set to current tty (required for SSH commit signing)
