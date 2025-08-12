#!/bin/sh

set -eu

get_volume() {
  vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
  vol="${vol%?}"
  muted=''
  [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')" = yes ] && muted='!'
  printf ' %s%s' "${vol:-n/a}" "$muted"
}

get_battery() {
  STATE_FILE="$XDG_STATE_HOME/.battery_notify_state"
  icon='/usr/share/icons/Adwaita/16x16/status/airplane-mode-symbolic.symbolic.png'
  cap=$(cat /sys/class/power_supply/BAT0/capacity)
  stat=$(cat /sys/class/power_supply/BAT0/status)
  sym='-'
  [ "$stat" = Charging ] && sym='+'
  [ "$stat" = Full ] && sym=''
  if [ "$stat" = Discharging ]; then
    for trg in 30 15; do
      if [ "$cap" -eq "$trg" ] && ! grep -qx "$trg" "$STATE_FILE" 2>/dev/null; then
        urgency=normal
        [ "$trg" -eq 15 ] && urgency=critical
        notify-send --urgency=$urgency -i "$icon" "Battery at ${trg}%"
        echo "$trg" >"$STATE_FILE"
      fi
    done
  else
    : >"$STATE_FILE" 2>/dev/null
  fi
  printf '%s%s%%' "$sym" "$cap"
}

get_wifi() {
  sta=$(iwctl station list | grep ' connected' | awk '{print $2}')
  ssid='n/a'
  [ -n "$sta" ] && ssid=$(iwctl station "$sta" show | awk -F'Connected network' '{ print $2 }' | xargs)
  printf '%s' "$ssid"
}

get_date() { date '+%R │ %d/%m/%Y'; }

pidfile=${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/spectrwm_bar.pid
echo $$ >"$pidfile"
trap 'rm -f "$pidfile"' EXIT

update_bar() {
  printf '%s │ %s │ %s │ %s\n' "$(get_volume)" "$(get_battery)" "$(get_wifi)" "$(get_date)"
}

trap : USR1
update_bar

while :; do
  update_bar
  sleep 2 &
  wait $! 2>/dev/null || true
done
