#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
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

  local sb=(${(@f)"$(git status -sb)"}) up_down us
  (( ${#sb[@]} > 1 )) && local dirty=*
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"

  if [[ -z "${sb##*...*}" ]]; then
    local usr="${${sb#*...}%% *}"
    [[ "${usr#*/}" == "$br" ]] && usr="${usr%%/*}"
    [[ -n "$usr" ]] && us="..$usr"
    [[ -n "${sb##*ahead*}" ]] || up_down+=^
    [[ -n "${sb##*behind*}" ]] || up_down+=v
    [ "${#up_down}" = 2 ] && up_down=^v
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi

  [[ -n "$up_down" ]] && up_down=" $up_down"

  PS1+="%F{magenta}$dirty$br$us$up_down%f "
}

__set_venv() {
    local dir="$PWD"
    while [[ "$dir" != "" && "$dir" != "/" ]]; do
        if [[ -x "$dir/venv/bin/python" ]]; then
            [[ -n "$VIRTUAL_ENV" ]] || . "$dir/venv/bin/activate"
            PS1+='%F{yellow}venv%f '
            return
        fi
        dir="$(dirname "$dir")"
    done
    type deactivate >/dev/null && deactivate
}

__set_beam_cursor() { echo -ne '\e[5 q'; }
__set_block_cursor() { echo -ne '\e[1 q'; }

zle-keymap-select() {
    [[ "$KEYMAP" = main || "$KEYMAP" = viins || -z "$KEYMAP" ]] && __set_beam_cursor || __set_block_cursor
}

zle -N zle-keymap-select

precmd() {
    code=$?
    __set_code
    __set_ssh
    __set_dir
    __set_git
    __set_venv
    __set_beam_cursor
}
