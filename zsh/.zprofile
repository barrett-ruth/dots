#!/usr/bin/env zsh

# XDG
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

eval "$(/opt/homebrew/bin/brew shellenv)"
. /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export BROWSER='/Applications/Google Chrome.app'
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
export GRADLE_USER_HOME="$XDG_CONFIG_HOME"/gradle
export LESSHISTFILE="$XDG_STATE_HOME"/lesshst
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export npm_config_userconfig="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PSQL_HISTORY="$XDG_STATE_HOME"/psql_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SCRIPTS="$HOME/.local/bin/scripts"
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ "$PATH" == *"$HOME/.local/bin"* ]] || export PATH="$PATH:$HOME/.local/bin"
[[ "$PATH" == *"$SCRIPTS"* ]] || export PATH="$PATH:$SCRIPTS"
[[ "$PATH" == *"$CARGO_HOME"/bin* ]] || export PATH="$PATH:$CARGO_HOME/bin"
[[ "$PATH" == *"$HOME/Library/Application Support/JetBrains/Toolbox/scripts"* ]] || export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
[[ "$PATH" == *"/opt/homebrew/opt/postgresql@15/bin"* ]] || export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --strip-cwd-prefix'
export FZF_TMUX=1

export THEME=dark
[[ "$THEME" == 'lite' ]] && green='#448C27' fg='#000000' purple='#7A3E9D' blue='#325CC0' bg='#F7F7F7' hi='#E7E7E7' yellow='#CB9000'
[[ "$THEME" == 'gruvbox' ]] && green='#A9B665' fg='#D4BE98' purple='#D3869B' blue='#7DAEA3' bg='#282828' hi='#32302F' yellow='#D8A657'
[[ "$THEME" == 'dark' ]] && green='#C3E88D' fg='#EEFFFF' purple='#B480D6' blue='#6E98EB' bg='#212121' hi='#2F2F2F' yellow='#FFCB7C'

FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info --no-bold'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=bg+:$hi,bg:$bg,fg:$fg,spinner:$purple,hl:$green:bold \
--color=header:$green,header:$yellow,pointer:$purple \
--color=marker:$purple,fg+:$fg,prompt:$yellow,hl+:$green:bold"
unset fg bg hi yellow green blue purple

. "$ZDOTDIR/.zaliases"
. "$XDG_CONFIG_HOME/fzf/fzf.zsh"

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
