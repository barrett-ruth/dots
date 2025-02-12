#!/usr/bin/env zsh

autoload -U compinit && compinit -d "$XDG_STATE_HOME"/zcompdump -u
autoload -U colors && colors
zmodload zsh/complist

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups hist_ignore_space

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export EDITOR='nvim'
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export MANPAGER='nvim +Man!'
export SAVEHIST=2000
export TERMINFO="$XDG_DATA_HOME"/terminfo
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
export QT_AUTO_SCREEN_SCALE_FACTOR=1

function prepend_path() {
    [[ "$PATH" == *"$1"* ]] && return
    export PATH="$1:$PATH";
}
function append_path() {
    [[ "$PATH" == *"$1"* ]] && return
    export PATH="$PATH:$1";
}

export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export BROWSER='chromium'
export NVM_DIR="$XDG_DATA_HOME" && . /usr/share/nvm/init-nvm.sh

append_path "$HOME"/.local/bin
prepend_path "$HOME"/.luarocks/bin
prepend_path "$HOME"/.local/bin/sst

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

export OPAMROOT="$XDG_DATA_HOME"/opam
eval "$(opam env)"

export SCRIPTS="$HOME"/.local/bin/scripts
append_path "$SCRIPTS"

export BOTO_CONFIG="$XDG_CONFIG_HOME"/boto/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_CONFIG_HOME"/gradle
export LESSHISTFILE=-
export MBSYNCRC="$XDG_CONFIG_HOME"/mbsync/config
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PRETTIERD_CONFIG_HOME="$XDG_STATE_HOME"/prettierd
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
test -f "$XDG_CONFIG_HOME"/rg/config && export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FZF_LUA_RG_OPTS="$(tr '\n' ' ' < "$RIPGREP_CONFIG_PATH")"
export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND="fd --type directory --strip-cwd-prefix"
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND="fd --type file --strip-cwd-prefix"
export FZF_TMUX=1

FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info'
if [ "$THEME" = "gruvbox" ]; then
    FZF_DEFAULT_OPTS+=" --color=fg:#D4BE98,bg:#282828,hl:#A9B665,fg+:#ffffff,bg+:#32302F,hl+:#89B482 \
--color=spinner:#D8A657 --color=marker:#D8A657 --color=pointer:#7DAEA3 \
--color=prompt:#E78A4E --color=info:#89B482 --color=border:#928374 --color=header:#928374"
else
    FZF_DEFAULT_OPTS+=" --color=fg:#000000,bg:#ffffff,hl:#ffa500,fg+:#000000,bg+:#ffffff,hl+:#ff0000 \
--color=spinner:#ffa500 --color=marker:#ffa500 --color=pointer:#0000ff \
--color=prompt:#ff00ff --color=info:#00ffff --color=border:#000000 --color=header:#000000"
fi
export FZF_DEFAULT_OPTS

. <(fzf --zsh)
. <(glab completion -s zsh); compdef _glab glab

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
