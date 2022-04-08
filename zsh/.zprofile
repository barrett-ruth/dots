#/usr/bin/env zsh

autoload -U compinit && compinit -u
autoload -U colors && colors
autoload zmv
zmodload zsh/complist

# Completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

# Vars
export SCRIPTS="$HOME/.local/bin/scripts"
[[ "$PATH" == *"$HOME/.local/bin:$SCRIPTS"* ]] || export PATH="$PATH:$HOME/.local/bin:$SCRIPTS"
export LC_ALL='en_US.UTF-8'

# XDG
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XRESOURCES="$XDG_CONFIG_HOME/X11/xresources"
touch "$XAUTHORITY"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Utils
export EDITOR='nvim'
export BROWSER='chromium'
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
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_DATA_HOME/.lesshst"
export NPM_CONFIG_PREFIX='/usr/local'
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/.node_repl_history"
export TS_NODE_REPL_HISTORY="$XDG_DATA_HOME/.ts_node_repl_history"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/password-store"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierd"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export _Z_DATA="$XDG_DATA_HOME/.z"
export _Z_EXCLUDE_DIRS=(__pycache__ .git .pki build cache dist docs node_modules undo venv)

# FZF
export FZF_ALT_C_COMMAND='fd -t d -H --strip-cwd-prefix'
export FZF_COMPLETION_TRIGGER='_'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd -t f -H --strip-cwd-prefix'
export FZF_CTRL_E_COMMAND='fd . ~/.config -t f -H'
export FZF_CTRL_W_COMMAND='fd . ~ -H'
export FZF_DEFAULT_OPTS='--no-info --no-bold --color=fg:#d4be98,bg:#282828,hl:bold:#a9b665 --color=fg+:#d4be98,hl+:bold:#a9b665,bg+:#282828 --color=pointer:#d4be98'
export FZF_TMUX=1

# Options
set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

# Plugins
. "$ZDOTDIR/.zaliases"
. "$ZDOTDIR/plugin/zsh-z/z.sh"
. "$ZDOTDIR/plugin/zsh-fzf/fzf/fzf.zsh"
. "$ZDOTDIR/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "$ZDOTDIR/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fzf-config-widget() {
  FZF_CTRL_T_COMMAND="$FZF_CTRL_E_COMMAND" fzf-file-widget
}
zle -N fzf-config-widget

fzf-home-widget() {
  FZF_CTRL_T_COMMAND="$FZF_CTRL_W_COMMAND" fzf-file-widget
}
zle -N fzf-home-widget

bindkey -v
for e in H E T G N P J K W; do
  eval "bindkey -r '^$e'"
done
bindkey '^W' fzf-home-widget
bindkey '^E' fzf-config-widget
bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

# X server
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" = '1' ] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
