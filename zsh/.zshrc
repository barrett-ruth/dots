#!/usr/bin/env zsh

. "$ZDOTDIR"/.zprofile

hi='#a89984'
line='#3c3836'
aqua='#89b482'
foc='#504945'

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
    [[ -n "$usr" ]] && us="%F{white}->%b%F{blue}$usr"
    [[ -n "${sb##*ahead*}" ]] || up_down+=↑
    [[ -n "${sb##*behind*}" ]] || up_down+=↓
    [ "${#up_down}" = 2 ] && up_down=^v
  elif [[ -z "${sb##*HEAD*}" ]]; then
      br=HEAD
  else
      br="${sb##* }"
  fi
  PS1+=" %F{white}$dirty%F{#e78a4e}$br$us%F{white}$up_down%F{$line} "
}

__set_venv() {
    venv="${VIRTUAL_ENV:-$PWD/venv}"
    [[ -x "$venv/bin/python" ]] || return
    [[ "$venv/bin/python" == *"$(which python)"* ]] || suffix=!
    [[ $1 ]] && PS1+="%F{$line}%K{$foc}" || PS1+="%F{$line}%K{$foc}"
    PS1+="%K{$foc} %F{#d8a657}$(basename "$venv")$suffix %F{$foc}"
}

__set_beam_cursor() { echo -ne '\e[5 q'; }
__set_block_cursor() { echo -ne '\e[1 q'; }

zle-keymap-select() {
    [[ "$KEYMAP" = main || "$KEYMAP" = viins || -z "$KEYMAP" ]] && __set_beam_cursor || __set_block_cursor
}

zle -N zle-keymap-select

precmd() {
    unset PS1 is_git
    PS1+="%K{$hi}%B%F{$bg}"
    __set_dir
    PS1+="%b%F{$hi}%K{$line}%F{$foc}"
    [[ -d .git ]] && is_git=true && __set_git || PS1+="%F{$line}"
    __set_venv "$is_git"
    PS1+="%k "
    __set_beam_cursor
    PS1+="%b%k%f"
}
