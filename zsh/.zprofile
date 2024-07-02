#!/usr/bin/env zsh

autoload -U compinit && compinit -d "$XDG_STATE_HOME/zcompdump" -u
autoload -U colors && colors
zmodload zsh/complist

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export EDITOR='nvim'
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export MANPAGER='nvim +Man!'
export SAVEHIST=2000
export TERMINFO="$XDG_DATA_HOME"/terminfo
export THEME='gruvbox'  # melange
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'


function prepend_path() {
    [[ "$PATH" == *"$1"* ]] && return
    test -d "$1" || return
    export PATH="$1:$PATH";
}
function append_path() {
    [[ "$PATH" == *"$1"* ]] && return
    test -d "$1" || return
    export PATH="$PATH:$1";
}

if [[ "$(uname -s)" == 'Darwin' ]]; then
    export XDG_RUNTIME_DIR=/tmp/user/"$UID"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    append_path '/opt/homebrew/opt/postgresql@15/bin'
    prepend_path '/opt/homebrew/opt/llvm/bin'
    . "$HOMEBREW_PREFIX"/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export BROWSER='/Applications/Chromium.app/Contents/MacOS/Chromium'
    export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
    export NVM_DIR="$XDG_DATA_HOME"/nvm && . "$NVM_DIR"/nvm.sh
else
    export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
    export BROWSER='chromium'
    . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export NVM_DIR="$XDG_DATA_HOME" && . /usr/share/nvm/init-nvm.sh
fi

test -d "$XDG_RUNTIME_DIR" || mkdir "$XDG_RUNTIME_DIR"


export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GOPATH="$XDG_DATA_HOME"/go
append_path "$GOPATH"/bin

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
append_path "$CARGO_HOME"/bin

export PNPM_HOME="$XDG_DATA_HOME"/pnpm
append_path "$PNPM_HOME"

export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
prepend_path "$PYENV_ROOT"/bin
eval "$(pyenv init -)"

ps aux | grep -q '[b]lackd' || { blackd >/dev/null 2>&1 &| }

export SCRIPTS="$HOME"/.local/bin/scripts
append_path "$SCRIPTS"

prepend_path "$HOME"/.luarocks/bin
append_path "$HOME"/.local/bin
prepend_path "$HOME"/.local/bin/sst

export BOTO_CONFIG="$XDG_CONFIG_HOME"/boto/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_CONFIG_HOME"/gradle
export LESSHISTFILE=-
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export TS_NODE_REPL_HISTORY="$XDG_STATE_HOME"/ts_node_repl_history
export PRETTIERD_CONFIG_HOME="$XDG_STATE_HOME"/prettierd
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FZF_LUA_RG_OPTS="$(tr '\n' ' ' < "$RIPGREP_CONFIG_PATH")"
export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND="fd --type directory --strip-cwd-prefix"
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND="fd --type file --strip-cwd-prefix"
export FZF_TMUX=1

FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info'
case "$THEME" in
    gruvbox)
        FZF_DEFAULT_OPTS+=" --color=fg:#D4BE98,bg:#282828,hl:#A9B665,fg+:#D4BE98,bg+:#32302F,hl+:#89B482 \
--color=spinner:#D8A657 --color=marker:#D8A657 --color=pointer:#7DAEA3 \
--color=prompt:#E78A4E --color=info:#89B482 --color=border:#928374 --color=header:#928374"
        ;;
    melange)
        FZF_DEFAULT_OPTS+=" --color=fg:#7D6658,bg:#F1F1F1,hl:#6E9B72,fg+:#54433A,bg+:#D9D3CE,hl+:#739797 \
--color=spinner:#BC5C00 --color=marker:#BC5C00 --color=pointer:#7892BD \
--color=prompt:#A06D00 --color=info:#739797 --color=border:#A98A78 --color=header:#A98A78"
        ;;
    light)
        FZF_DEFAULT_OPTS+=" --color=fg:#000000,bg:#FFFFFF,hl:#1A7F37,fg+:#000000,bg+:#F1F1F2,hl+:#0550AE \
--color=spinner:#953800 --color=marker:#953800 --color=pointer:#CF222E \
--color=prompt:#8250DF --color=info:#0550AE --color=border:#CEE1F8 --color=header:#CEE1F8"
        ;;
esac
export FZF_DEFAULT_OPTS

eval "$(fzf --zsh)"

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fzf_select | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}
zle -N fzf-config-widget

bindkey -r '^R'
bindkey '^E' fzf-config-widget
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
bindkey '^H' fzf-history-widget

. "$ZDOTDIR"/.zaliases

bindkey -v
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

# [[ "$(uname)" = 'Linux' ]] && [[ -z "$DISPLAY" ]] && [[ $XDG_VTNR = 1 ]] && startx "$XDG_CONFIG_HOME"/X11/xinitrc
