#!/usr/bin/env zsh

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

if [[ "$(uname -s)" == 'Darwin' ]]; then
    export XDG_RUNTIME_DIR="/tmp/user/$UID"
    dir="/tmp/user/$UID"
    [[ -d "$dir" ]] || mkdir -p "$XDG_RUNTIME_DIR"
    append_path '/opt/homebrew/opt/postgresql@15/bin'
    prepend_path '/opt/homebrew/opt/llvm/bin'
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export BROWSER='/Applications/Chromium.app/Contents/MacOS/Chromium'
    export CPPFLAGS='-I/opt/homebrew/opt/llvm/include'
    export LDFLAGS='-L/opt/homebrew/opt/llvm/lib'
    . "$XDG_CONFIG_HOME"/fzf/fzf.zsh
else
    export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
    test -f "$XDG_RUNTIME_DIR"/.Xauthority || touch "$XDG_RUNTIME_DIR"/.Xauthority
    export BROWSER='chromium'
fi

autoload -U compinit && compinit -d "$XDG_STATE_HOME/zcompdump" -u
autoload -U colors && colors
zmodload zsh/complist

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

function prepend_path() { [[ "$PATH" == *"$1"* ]] || export PATH="$1:$PATH"; }
function append_path() { [[ "$PATH" == *"$1"* ]] || export PATH="$PATH:$1"; }


export NVM_DIR="$XDG_DATA_HOME"/nvm
nvm() { unset -f nvm && . "$NVM_DIR/nvm.sh" && nvm "$@"; }

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

. "${HOMEBREW_PREFIX:-/usr}"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export SAVEHIST=2000
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

export BOTO_CONFIG="$XDG_CONFIG_HOME"/boto/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GRADLE_USER_HOME="$XDG_CONFIG_HOME"/gradle
export LESSHISTFILE=-
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export npm_config_userconfig="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TS_NODE_REPL_HISTORY="$XDG_STATE_HOME"/ts_node_repl_history
export PRETTIERD_CONFIG_HOME="$XDG_STATE_HOME"/prettierd
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export VIRTUAL_ENV_DISABLE_PROMPT=1

export GOPATH="$XDG_DATA_HOME"/go
append_path "$GOPATH"/bin

export CARGO_HOME="$XDG_DATA_HOME"/cargo
append_path "$CARGO_HOME"/bin

export PNPM_HOME="$XDG_DATA_HOME/pnpm"
append_path "$PNPM_HOME"

export PYENV_ROOT="$XDG_CONFIG_HOME"/pyenv
prepend_path "$PYENV_ROOT"/bin
eval "$(pyenv init -)"

export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
prepend_path "$RBENV_ROOT"/shims
eval "$(rbenv init - zsh)"

export SCRIPTS="$HOME/.local/bin/scripts"
append_path "$SCRIPTS"

prepend_path "$HOME/.luarocks/bin"
append_path "$HOME/.local/bin"
prepend_path "$HOME"/.local/bin/sst

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --strip-cwd-prefix'
export FZF_TMUX=1
export FZF_DEFAULT_OPTS="--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info \
--color=fg:#D4BE98,bg:#282828,hl:#A9B665,fg+:#D4BE98,bg+:#32302F,hl+:#89B482 \
--color=spinner:#D8A657 --color=marker:#D8A657 --color=pointer:#7DAEA3 \
--color=prompt:#E78A4E --color=info:#89B482 --color=border:#928374 --color=header:#928374"

eval "$(fzf --zsh)"
. "$ZDOTDIR/.zaliases"

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fsel | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}
zle -N fzf-config-widget

bindkey -v
bindkey -r '^R'
bindkey '^E' fzf-config-widget
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
bindkey '^H' fzf-history-widget
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

[[ "$(uname -s)" = 'Linux' ]] && [[ -z "$DISPLAY" ]] && [[ $XDG_VTNR = 1 ]] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
