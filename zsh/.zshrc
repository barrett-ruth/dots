#!/usr/bin/env zsh

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

_fix_venv_prompt() {
  if [[ -n $VIRTUAL_ENV && $VIRTUAL_ENV_DISABLE_PROMPT == "1" ]]; then
    unset VIRTUAL_ENV_DISABLE_PROMPT
  fi
}
add-zsh-hook precmd _fix_venv_prompt
