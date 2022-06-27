#!/usr/bin/env zsh

autoload -U compinit && compinit -u
autoload -U colors && colors
zmodload zsh/complist

# Completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

# Options
set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

# Vars
export SCRIPTS="$HOME/.local/bin/scripts"
[[ "$PATH" == *"$HOME/.local/bin:$SCRIPTS"* ]] || export PATH="$PATH:$HOME/.local/bin:$SCRIPTS"
export LC_ALL='en_US.UTF-8'

# XDG
export XRESOURCES="$XDG_CONFIG_HOME/X11/xresources"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
[[ -f "$XAUTHORITY" ]] || touch "$XAUTHORITY"

# Utils
export BROWSER='qutebrowser'
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='dd/mm/yyyy'
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export SAVEHIST=2000
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# Programs
export FONTCONFIG=/usr/share/fonts
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export NPM_CONFIG_PREFIX='/usr/local'
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/.node_repl_history"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/password-store"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierd"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export VIRTUAL_ENV_DISABLE_PROMPT=1

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --hidden --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --hidden --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --no-info --no-bold --color=fg:#d4be98,bg:#282828,hl:bold:#a9b665 --color=fg+:#d4be98,hl+:bold:#a9b665,bg+:#282828 --color=pointer:#d4be98'
export FZF_TMUX=1

# Plugins
. "$ZDOTDIR/.zaliases"
. "$XDG_CONFIG_HOME/fzf/fzf.zsh"
. "$ZDOTDIR/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fzf-config-widget() {
    file="$(FZF_CTRL_T_COMMAND="fd --type file --hidden . ~/.config | sed 's|$HOME|~|g'" __fsel | cut -c2-)"
    LBUFFER+="$file"
    zle reset-prompt
}
zle -N fzf-config-widget

bindkey -v
bindkey -r '^[c' '^E' '^R' '^T'
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
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
