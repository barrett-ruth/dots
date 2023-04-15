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

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export LESSHISTFILE="$XDG_STATE_HOME"/lesshst
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export VIRTUAL_ENV_DISABLE_PROMPT=1

[[ "$PATH" == *"$HOME/.local/bin"* ]] || export PATH="$PATH:$HOME/.local/bin"
export SCRIPTS="$HOME/.local/bin/scripts"
[[ "$PATH" == *"$SCRIPTS"* ]] || export PATH="$PATH:$SCRIPTS"
[[ "$PATH" == *"$GOPATH"/bin* ]] || export PATH="$PATH:$GOPATH/bin"
[[ "$PATH" == *"$CARGO_HOME"/bin* ]] || export PATH="$PATH:$CARGO_HOME/bin"
[[ "$PATH" == *"$RUSTUP_HOME"/bin* ]] || export PATH="$PATH:$RUSTUP_HOME/toolchains/stable-aarch64-apple-darwin/bin"
[[ "$PATH" == *"$HOME/Library/Application Support/JetBrains/Toolbox/scripts"* ]] || export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
[[ "$PATH" == *"/opt/homebrew/opt/postgresql@15/bin"* ]] || export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

export FZF_COMPLETION_TRIGGER=\;
export FZF_ALT_C_COMMAND='fd --type directory --strip-cwd-prefix'
export FZF_CTRL_R_OPTS='--reverse'
export FZF_CTRL_T_COMMAND='fd --type file --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--bind=ctrl-a:select-all --bind=ctrl-f:half-page-down --bind=ctrl-b:half-page-up --no-scrollbar --no-info --no-bold --color=bg+:#32302f,bg:#292828,spinner:#89b482,hl:#7daea3 --color=fg:#bdae93,header:#7daea3,info:#d8a657,pointer:#89b482 --color=marker:#89b482,fg+:#ebdbb2,prompt:#d8a657,hl+:#7daea3'
export FZF_TMUX=1

. "$ZDOTDIR/.zaliases"
. "$XDG_CONFIG_HOME/fzf/fzf.zsh"

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
