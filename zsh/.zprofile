#!/usr/bin/env zsh

# XDG
export XDG_RUNTIME_DIR="/tmp/user/$UID"
if [[ "$(uname -s)" == 'Darwin' ]]; then
    dir="/tmp/user/$UID"
    [[ -d "$dir" ]] || mkdir -p "$XDG_RUNTIME_DIR"
fi
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

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

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init -)"
. /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# export THEME='light'
# export THEME='gruvbox-light'
export THEME='gruvbox-dark'

export NVM_DIR="$XDG_DATA_HOME"/nvm
nvm() { unset -f nvm && . "$NVM_DIR/nvm.sh" && nvm "$@"; }

export LDFLAGS='-L/opt/homebrew/opt/llvm/lib'
export CPPFLAGS='-I/opt/homebrew/opt/llvm/include'

export PYENV_ROOT="$XDG_CONFIG_HOME"/pyenv

export BROWSER='/Applications/Chromium.app/Contents/MacOS/Chromium'
export GH_BROWSER="$BROWSER"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export SAVEHIST=2000
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

export BOTO_CONFIG="$XDG_CONFIG_HOME"/boto/config
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GRADLE_USER_HOME="$XDG_CONFIG_HOME"/gradle
export LESSHISTFILE=-
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export npm_config_userconfig="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export TS_NODE_REPL_HISTORY="$XDG_STATE_HOME"/ts_node_repl_history
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PRETTIERD_CONFIG_HOME="$XDG_STATE_HOME"/prettierd
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SCRIPTS="$HOME/.local/bin/scripts"
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export VIRTUAL_ENV_DISABLE_PROMPT=1

prepend_path '/opt/homebrew/opt/llvm/bin'
prepend_path "$PYENV_ROOT/bin"
append_path "$PNPM_HOME"
append_path "$HOME/.local/bin"
append_path "$SCRIPTS"
prepend_path "$HOME/.luarocks/bin"
append_path "$CARGO_HOME/bin"
append_path '/opt/homebrew/opt/postgresql@15/bin'
append_path "$GOPATH/bin"

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --strip-cwd-prefix'
export FZF_TMUX=1

FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info'
if [[ "$THEME" == 'light' ]]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:#f1f1f2,bg:#FFFFFF,spinner:#8250DF,hl:#8250DF \
--color=fg:#000000,header:#8250DF,info:#9A6700,pointer:#8250DF \
--color=marker:#1A7F37,fg+:#000000,prompt:#9A6700,pointer:#1A7F37,hl+:#8250DF"
elif [[ "$THEME" == 'gruvbox-dark' ]]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#D4BE98,bg:#282828,hl:#A9B665,fg+:#D4BE98,bg+:#32302F,hl+:#89B482 \
--color=spinner:#D8A657 --color=marker:#D8A657 --color=pointer:#7DAEA3 \
--color=prompt:#E78A4E --color=info:#89B482 --color=border:#928374 --color=header:#928374"
fi

. "$ZDOTDIR/.zaliases"
. /opt/homebrew/opt/fzf/shell/key-bindings.zsh
. "$XDG_CONFIG_HOME"/fzf/fzf.zsh

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
