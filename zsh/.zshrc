#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
    PS1=''
    [[ $code -eq 0 ]] || PS1=" %F{red}$code%f"
}

__set_ssh() {
    [[ "$SSH_CONNECTION" ]] && PS1+=" %F{095}%n%F{058}@%F{243}%m"
}

__shrink() {
    dir=${PWD/#$HOME/\~} base="$(basename $dir)"
    typeset -a tree=(${(s:/:)dir})

    if [[ $tree[1] == '~' ]]; then
        res='~'
        shift tree
    else
        echo '%c' && exit
    fi
    for dir in $tree; do
        [[ $dir == $base ]] && res+=/$dir && break
        res+=/$dir[1]
        [[ $dir[1] == '.' ]] && res+=$dir[2]
    done
    echo $res
}

__set_dir() {
    PS1+=" %F{cyan}$(__shrink) "
}

__set_git() {
  if [[ ! -d .git ]]; then
      is_git=false
      return
  fi
  is_git=true
  setopt +o nomatch
  local sb=(${(@f)"$(git status -sb)"}) up_down us
  (( ${#sb[@]} > 1 )) && local dirty=*
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"
  if [[ -z "${sb##*...*}" ]]; then
    local usi="${sb##*.}"
    local usr="${usi%%/*}"
    [[ -n "$usr" ]] && us="%f→%F{blue}$usr"
    [[ -n "${sb##*ahead*}" ]] || up_down+=↑
    [[ -n "${sb##*behind*}" ]] || up_down+=↓
    [ "${#up_down}" = 2 ] && up_down=↑↓
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi
  PS1+="%f$dirty%F{green}$br$us%f$up_down "
}

__set_venv() {
    ! test -x venv/bin/python || . venv/bin/activate
    [[ -z "$VIRTUAL_ENV" ]] && return
    PS1+='%F{yellow}venv'
    [[ "$(dirname "$VIRTUAL_ENV")" == "$PWD" ]] || PS1+='!'
    PS1+='%f '
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
    PS1+='%f'
}
