#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
    code=$?``
    PS1=''
    [[ $code -eq 0 ]] || PS1=" %F{red}$code%f"
}

__set_ssh() {
    [[ "$SSH_CONNECTION" ]] && PS1+=" %m"
}

__shrink() {
    dir=${PWD/#$HOME/\~} base="$(basename $dir)"
    typeset -a tree=(${(s:/:)dir})

    if [[ "$dir[1]" == '/' ]] || [[ "$tree[1]" != '~' ]]; then
        echo "$PWD"
        exit
    fi
    res='~'
    shift tree
    for dir in $tree; do
        [[ $dir == $base ]] && res+=/$dir && break
        res+=/$dir[1]
        [[ $dir[1] == '.' ]] && res+=$dir[2]
    done
    echo "$res"
}

__set_dir() {
    PS1+=" %F{blue}$(__shrink)%f "
}

__set_git() {
  [[ ! -d .git ]] && return

  setopt +o nomatch

  local sb=(${(@f)"$(git status -sb)"}) us
  (( ${#sb[@]} > 1 )) && local dirty=*
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"

  if [[ -z "${sb##*...*}" ]]; then
    local usr="${${sb#*...}%% *}"
    [[ "${usr#*/}" == "$br" ]] && usr="${usr%%/*}"
    [[ -n "$usr" ]] && us="..$usr"
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi

  PS1+="%F{magenta}$dirty$br$us%f "
}

__set_venv() {
    local dir="$PWD"
    while [[ "$dir" != "" && "$dir" != "/" ]]; do
        for venv in venv .venv; do
            if [[ -x "$dir/$venv/bin/python" ]]; then
                . "$dir/$venv/bin/activate"
                PS1+="%F{yellow}($venv)%f "
                return
            fi
        done
        dir="$(dirname "$dir")"
    done
    type deactivate >/dev/null && deactivate
}

function __set_beam_cursor {
    echo -ne '\e[6 q'
}

function __set_block_cursor {
    echo -ne '\e[2 q'
}

function __set_symbol() {
    PS1+='$ '
}

function zle-keymap-select {
  case $KEYMAP in
    vicmd) __set_block_cursor;;
    viins|main) __set_beam_cursor;;
  esac
}
zle -N zle-keymap-select

function zle-line-init {
    __set_beam_cursor
}
zle -N zle-line-init

builtin typeset -ag precmd_functions
precmd_functions+=(__set_code __set_ssh __set_dir __set_git __set_venv __set_beam_cursor __set_symbol)

bindkey '^F' fzf-file-widget
bindkey '^G' fzf-cd-widget
