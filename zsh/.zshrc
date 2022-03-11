#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

__set_code() {
    PS1=' '
    [ "$1" = '0' ] || PS1+="%F{red}$1 "
}
__set_ssh() { [ "$SSH_CONNECTION" ] && PS1+="%F{138}%h%F{white}@%F{95}%m " }

__set_dir() { PS1+="%F{cyan}%c "; }

setopt +o nomatch
__set_git() {
  [ -d .git ] || return
  local sb=(${(@f)"$(git status -sb)"}) up_down us
  (( ${#sb[@]} > 1 )) && local dirty="*"
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"
  if [ -z "${sb##*...*}" ]; then
    local usi="${sb##*.}"
    local usr="${usi%%/*}"
    local usb="${${usi##*/}%% *}"
    [ "$usr" ] && us="%F{white}->%F{green}$usr"
    [ "$usb" ] && us+="%F{white}/%F{blue}$usb"
    [ "${sb##*ahead*}" ] || up_down+='^'
    [ "${sb##*behind*}" ] || up_down+='v'
    [ "${#up_down}" = '2' ] && up_down='^v'
  elif [ -z "${sb##*HEAD*}" ]; then
      br='HEAD'
  else
      br="${sb##* }"
  fi
  PS1+="%F{white}$dirty%F{blue}$br$us%F{white}$up_down "
}

__set_venv() {
    venv="${VIRTUAL_ENV:-$PWD/venv}"
    [ -d "$venv" ] || return
    . "$venv/bin/activate"
    PS1+="%F{magenta}$(basename "$venv") "
}

__set_symbol() { PS1+="%F{white}>%F{white} "; }
__set_beam_cursor() { echo -ne '\e[5 q'; }
__set_block_cursor() { echo -ne '\e[1 q'; }

zle-keymap-select() {
    [ "$KEYMAP" = 'main' -o "$KEYMAP" = 'viins' -o "$KEYMAP" = '' ] && __set_beam_cursor || __set_block_cursor
}

zle -N zle-keymap-select

precmd() {
    __set_code "$?"
    __set_ssh
    __set_dir
    __set_git
    __set_venv
    __set_symbol
    __set_beam_cursor
}
