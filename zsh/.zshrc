#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

hi='#a89984'
focbg='#504945'
aqua='#89b482'

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
    PS1+=" $(__shrink) "
}

__set_git() {
  setopt +o nomatch
  local sb=(${(@f)"$(git status -sb)"}) up_down us
  (( ${#sb[@]} > 1 )) && local dirty=*
  sb="${sb[1]}"
  local br="${${sb%%.*}##* }"
  if [[ -z "${sb##*...*}" ]]; then
    local usi="${sb##*.}"
    local usr="${usi%%/*}"
    local usb="${${usi##*/}%% *}"
    [[ -n "$usr" ]] && us="%F{white}->%F{blue}$usr"
    [[ -n "$usb" ]] && us+="%F{white}/%F{red}$usb"
    [[ -n "${sb##*ahead*}" ]] || up_down+=^
    [[ -n "${sb##*behind*}" ]] || up_down+=v
    [ "${#up_down}" = 2 ] && up_down=^v
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi
  PS1+=" %F{white}$dirty%F{#e78a4e}$br$us%F{white}$up_down "
}

__set_venv() {
    venv="${VIRTUAL_ENV:-$PWD/venv}"
    [[ -x "$venv/bin/python" ]] || return
    [[ "$venv/bin/python" == *"$(which python)"* ]] || suffix=!
    [[ $1 ]] && PS1+="%F{#d4be98}"
    PS1+=" %K{$focbg}%F{#d8a657}$(basename "$venv")$suffix "
}

__set_beam_cursor() { echo -ne '\e[5 q'; }
__set_block_cursor() { echo -ne '\e[1 q'; }

zle-keymap-select() {
    [[ "$KEYMAP" = main || "$KEYMAP" = viins || -z "$KEYMAP" ]] && __set_beam_cursor || __set_block_cursor
}

zle -N zle-keymap-select

precmd() {
    unset PS1
    PS1+="%K{$hi}%B%F{$bg}"
    __set_dir
    PS1+="%b%F{$hi}%K{$focbg}%F{#3c3836}"
    [[ -d .git ]] && is_git=true && __set_git
    __set_venv "$is_git"
    PS1+="%F{$focbg}%k "
    __set_beam_cursor
    PS1+="%b%k%f"
}
