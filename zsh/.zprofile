#/usr/bin/env zsh

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

# Utils
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HYPHEN_INSENSITIVE='true'
export HIST_STAMPS='mm/dd/yyyy'
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=2000
export HISTFILESIZE=2000
export SAVEHIST=2000
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# Programs
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_DATA_HOME/.lesshst"
export NPM_CONFIG_PREFIX='/usr/local'
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/.node_repl_history"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierd"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export _Z_DATA="$XDG_DATA_HOME/z"
export _Z_EXCLUDE_DIRS=(__pycache__ .mypy_cache .git .pki build cache dist doc node_modules undo venv)

# Plugins
. "$ZDOTDIR/.zaliases"
. "$ZDOTDIR/plugin/zsh-z/z.sh"
. "$ZDOTDIR/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "$ZDOTDIR/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

bindkey -v
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

# X server
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" = '1' ] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
