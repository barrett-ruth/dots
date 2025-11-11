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

export GHOSTTY_SHELL_INTEGRATION_NO_CURSOR=1

export EDITOR='nvim'
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export MANPAGER='nvim +Man!'
export SAVEHIST=2000
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERM=xterm-ghostty
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

export BROWSER='chromium'
export NVM_DIR="$XDG_DATA_HOME" && . /usr/share/nvm/init-nvm.sh

append_path "$HOME"/.local/bin
prepend_path "$HOME"/.luarocks/bin
prepend_path "$HOME"/.local/bin/sst

export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GOPATH="$XDG_DATA_HOME"/go
append_path "$GOPATH"/bin

export PNPM_HOME="$XDG_DATA_HOME"/pnpm
append_path "$PNPM_HOME"

export OPAMROOT="$XDG_DATA_HOME"/opam
eval "$(opam env)"

export SCRIPTS="$HOME"/.local/bin/scripts
append_path "$SCRIPTS"

append_path "$HOME"/.cargo/bin

export BOTO_CONFIG="$XDG_CONFIG_HOME"/boto/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
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

export FZF_COMPLETION_TRIGGER=\;
export FZF_CTRL_R_OPTS='--reverse'
export FZF_TMUX=1
export FZF_CTRL_T_COMMAND='rg --files --hidden --color=auto'
export FZF_DEFAULT_OPTS='--color=light --bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info'
export LIBVIRT_DEFAULT_URI=qemu:///system

if [ "$THEME" = "gruvbox" ]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#ebdbb2,bg:#1d2021,hl:#fabd2f --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f --color=info:#83a598,prompt:#b8bb26,pointer:#ebdbb2,marker:#83a598,spinner:#d3869b"
elif [ "$THEME" = "midnight" ]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#e0e0e0,bg:#121212,hl:#7aa2f7 --color=fg+:#e0e0e0,bg+:#2d2d2d,hl+:#7aa2f7 --color=info:#98c379,prompt:#7aa2f7,pointer:#e0e0e0,marker:#98c379,spinner:#e0e0e0"
elif [ "$THEME" = "daylight" ]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=fg:#1a1a1a,bg:#f5f5f5,hl:#3b5bdb --color=fg+:#1a1a1a,bg+:#ebebeb,hl+:#3b5bdb --color=info:#2d7f3e,prompt:#3b5bdb,pointer:#1a1a1a,marker:#2d7f3e,spinner:#1a1a1a"
fi

. <(fzf --zsh)

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fzf_select | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}

zle -N fzf-config-widget

bindkey '^E' fzf-config-widget

. "$ZDOTDIR"/.zaliases

bindkey -v
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    if [[ "$USE_WAYLAND" ]]; then
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=sway
        export ELECTRON_OZONE_PLATFORM_HINT=wayland
        export GTK_USE_PORTAL=1
        export OZONE_PLATFORM=wayland
        export QT_QPA_PLATFORM=wayland
        export GDK_BACKEND=wayland,x11
        export SDL_VIDEODRIVER=wayland
        ln -sf "$XDG_CONFIG_HOME/sway/themes/$THEME" ~/.config/sway/theme
        exec sway
    else
        export XDG_SESSION_TYPE=x11
        exec startx
    fi
fi
