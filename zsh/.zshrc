#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
    PS1=''
    [[ $code -eq 0 ]] || PS1=" %F{red}$code%f"
}

__set_dir() {
    PS1+=" %F{cyan}%~ "
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
    local venv="${VIRTUAL_ENV:-$PWD/venv}"
    [[ -x "$venv/bin/python" ]] || return
    [[ "$venv/bin/python" == *"$(which python)"* ]] || local suffix=!
    PS1+=" %F{yellow}$(basename "$venv")$suffix%f "
}

precmd() {
    code=$?
    __set_code
    __set_dir
    __set_git
    __set_venv
    PS1+="%f"
}
