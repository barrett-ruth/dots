#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
    PS1=' '
    [[ $1 -eq 0 ]] || PS1+="%F{red}$1 "
}
__set_ssh() { [[ -n "$SSH_CONNECTION" ]] && PS1+="%F{138}%h%F{white}@%F{95}%m " }

__shrink () {
    dir=${PWD/#$HOME/\~} base="$(basename $dir)"
    typeset -a tree=(${(s:/:)dir})

    if [[ $tree[1] == '~' ]]; then
        res='~'
        shift tree
    else
        echo "%c" && exit
    fi
    for dir in $tree; do
        [[ $dir == $base ]] && res+=/$dir && break
        res+=/$dir[1]
        [[ $dir[1] == '.' ]] && res+=$dir[2]
    done
    echo $res
}

__set_dir() {
    PS1+="%F{cyan}$(__shrink) ";
}

__set_git() {
  setopt +o nomatch
  [[ -d .git ]] || return
  local sb=(${(@f)"$(git status -sb)"}) up_down us
  (( ${#sb[@]} > 1 )) && local dirty=*
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"
  if [[ -z "${sb##*...*}" ]]; then
    local usi="${sb##*.}"
    local usr="${usi%%/*}"
    local usb="${${usi##*/}%% *}"
    [[ -n "$usr" ]] && us="%F{white}->%F{green}$usr"
    [[ -n "$usb" ]] && us+="%F{white}/%F{blue}$usb"
    [[ -n "${sb##*ahead*}" ]] || up_down+=^
    [[ -n "${sb##*behind*}" ]] || up_down+=v
    [ "${#up_down}" = 2 ] && up_down=^v
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi
  PS1+="%F{white}$dirty%F{blue}$br$us%F{white}$up_down "
}

__set_venv() {
    venv="${VIRTUAL_ENV:-$PWD/venv}"
    [[ -x "$venv/bin/python" ]] || return
    [[ "$venv/bin/python" == *"$(which python)"* ]] || suffix=!
    PS1+="%F{magenta}$(basename "$venv")$suffix "
}

__set_symbol() { PS1+="%F{white}> "; }
__set_beam_cursor() { echo -ne '\e[5 q'; }
__set_block_cursor() { echo -ne '\e[1 q'; }

zle-keymap-select() {
    [[ "$KEYMAP" = main || "$KEYMAP" = viins || -z "$KEYMAP" ]] && __set_beam_cursor || __set_block_cursor
}

zle -N zle-keymap-select

precmd() {
    __set_code $?
    __set_ssh
    __set_dir
    __set_git
    __set_venv
    __set_symbol
    __set_beam_cursor
}

