#!/usr/bin/env zsh

autoload -U compinit && compinit -d "$XDG_STATE_HOME/zcompdump" -u
autoload -U colors && colors
zmodload zsh/complist

# Completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

# Options
set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

# XDG
export XRESOURCES="$XDG_CONFIG_HOME/X11/xresources"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
[[ -f "$XAUTHORITY" ]] || touch "$XAUTHORITY"

# Utils
export BROWSER='chromium'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$XDG_STATE_HOME/zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export SAVEHIST=2000
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# Programs
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Path
export SCRIPTS="$HOME/.local/bin/scripts"
[[ "$PATH" == *"$HOME/.local/bin"* ]] || export PATH="$PATH:$HOME/.local/bin"
[[ "$PATH" == *"$SCRIPTS"* ]] || export PATH="$PATH:$SCRIPTS"

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --hidden --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --hidden --strip-cwd-prefix --follow'
export FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-info --no-bold --color=fg:#d4be98,bg:#282828,hl:bold:#a9b665 --color=fg+:#d4be98,hl+:bold:#a9b665,bg+:#282828 --color=pointer:#d4be98'
export FZF_TMUX=1

# Plugins
. "$ZDOTDIR/.zaliases"
. "$XDG_CONFIG_HOME/fzf/fzf.zsh"
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fsel | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}
zle -N fzf-config-widget

bindkey -v
bindkey '^E' fzf-config-widget
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
bindkey '^H' fzf-history-widget
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

# X server
[[ -z "$DISPLAY" ]] && [[ $XDG_VTNR = 1 ]] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
