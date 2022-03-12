#!/usr/bin/env zsh

autoload -U compinit && compinit
autoload -U colors && colors
autoload zmv

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
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_CONFIG_HOME/less/lesshst"
export npm_config_prefix='/usr/local'
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/password-store"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierrc"

# FZF
export FZF_CTRL_T_COMMAND='fd -t f -H --strip-cwd-prefix'
export FZF_ALT_C_COMMAND='fd -H --strip-cwd-prefix -t d'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_DEFAULT_OPTS='--no-info --no-bold --color=fg:#d4be98,bg:#282828,hl:bold:#a9b665 --color=fg+:#d4be98,hl+:bold:#a9b665,bg+:#282828 --color=pointer:#d4be98'
export FZF_TMUX=1

# Options
set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups

# Plugins
. "$ZDOTDIR/.zaliases"
. "$ZDOTDIR/plugin/zsh-fzf/fzf/fzf.zsh"
. "$ZDOTDIR/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh"
. "$ZDOTDIR/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
. "$XDG_CONFIG_HOME/nvm/nvm.sh" --no-use

# Bindings
__fsel_config() {
  cd ~/.config
  local item
  { eval "$FZF_CTRL_T_COMMAND" | FZF_DEFAULT_OPTS="--height 40% --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "~/.config/${(q)item} "
  done
    }
  echo
}

fzf-config-widget() {
    LBUFFER="$LBUFFER$(__fsel_config)"
    zle reset-prompt
}

bindkey -v
bindkey -r '^E'
zle -N fzf-config-widget
bindkey '^E' fzf-config-widget
bindkey -r '^R'
bindkey '^R' fzf-history-widget
bindkey -r '^T'
bindkey '^F' fzf-file-widget
bindkey -r '^G'
bindkey '^G' fzf-cd-widget
bindkey '^[[P' delete-char
bindkey -r '^P'
bindkey '^P' up-line-or-history
bindkey -r '^N'
bindkey '^N' down-line-or-history
bindkey -r '^J'
bindkey '^J' backward-char
bindkey -r '^K'
bindkey '^K' forward-char

# X server
[ -z "$DISPLAY" ] && [ "$XDG_VTNR" = '1' ] && startx "$XDG_CONFIG_HOME/X11/xinitrc"
