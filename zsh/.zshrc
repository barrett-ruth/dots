#!/usr/bin/env zsh

autoload -U compinit && compinit -d "$XDG_STATE_HOME"/zcompdump -u
autoload -U colors && colors
zmodload zsh/complist

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-za-z}'

set completion-ignore-case on
unset completealiases
setopt auto_cd incappendhistory extendedhistory histignorealldups hist_ignore_space

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
export HYPHEN_INSENSITIVE='true'

if [[ ! -d "$ZDOTDIR/pure" ]]; then
  git clone --depth=1 https://github.com/sindresorhus/pure.git "$ZDOTDIR/pure"
fi

export PURE_PROMPT_SYMBOL=">"
export PURE_PROMPT_VICMD_SYMBOL="<"
export PURE_GIT_UP_ARROW="^"
export PURE_GIT_DOWN_ARROW="v"
export PURE_GIT_STASH_SYMBOL="="
export PURE_CMD_MAX_EXEC_TIME=5
export PURE_GIT_PULL=0
export PURE_GIT_UNTRACKED_DIRTY=1

zstyle ':prompt:pure:git:stash' show yes

fpath+=("$ZDOTDIR"/pure)
autoload -Uz promptinit && promptinit
prompt pure

autoload -Uz add-zle-hook-widget

function _pure_cursor_shape() {
  case $KEYMAP in
    vicmd) echo -ne '\e[2 q' ;;
    viins|main) echo -ne '\e[6 q' ;;
  esac
}

function _pure_cursor_init() {
  echo -ne '\e[6 q'
}

add-zle-hook-widget zle-keymap-select _pure_cursor_shape
add-zle-hook-widget zle-line-init _pure_cursor_init

export FZF_COMPLETION_TRIGGER=\;
export FZF_CTRL_R_OPTS='--reverse'
export FZF_TMUX=1
export FZF_CTRL_T_COMMAND='rg --files --hidden --color=auto'
export FZF_DEFAULT_OPTS='--color=light --bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info'

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

bindkey -v
bindkey '^[[3~' delete-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^J' backward-char
bindkey '^K' forward-char

eval "$(direnv hook zsh)"

. "$ZDOTDIR"/.zaliases
