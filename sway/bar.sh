#!/bin/sh
set -eu

STATE_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/.battery_notify_state"
PIDFILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/swaybar.pid"

j() { printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g'; }

get_volume() {
  vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | awk 'NR==1{print $5}')
  vol="${vol%?}"
  muted=''
  [ "$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk 'NR==1{print $2}')" = yes ] && muted='!'
  printf ' %s%s' "${vol:-n/a}" "$muted"
}

get_battery() {
  mkdir -p "$(dirname "$STATE_FILE")"
  icon='/usr/share/icons/Adwaita/16x16/status/airplane-mode-symbolic.symbolic.png'
  cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo n/a)
  stat=$(cat /sys/class/power_supply/BAT0/status   2>/dev/null || echo '')
  sym='-'
  [ "$stat" = Charging ] && sym='+'
  [ "$stat" = Full ] && sym=''
  if [ "$stat" = Discharging ] && [ "$cap" != n/a ]; then
    for trg in 30 15; do
      if [ "$cap" -eq "$trg" ] && ! grep -qx "$trg" "$STATE_FILE" 2>/dev/null; then
        urgency=normal; [ "$trg" -eq 15 ] && urgency=critical
        notify-send --urgency="$urgency" -i "$icon" "Battery at ${trg}%"
        echo "$trg" >"$STATE_FILE"
      fi
    done
  else
    : >"$STATE_FILE" 2>/dev/null || true
  fi
  printf '%s%s%%' "$sym" "$cap"
}

get_wifi() {
  sta=$(iwctl station list 2>/dev/null | awk '/ connected/{print $2; exit}') || true
  ssid='n/a'
  [ -n "${sta:-}" ] && ssid=$(iwctl station "$sta" show 2>/dev/null | awk -F'Connected network' 'NF>1{print $2}' | xargs || echo 'n/a')
  printf '%s' "${ssid:-n/a}"
}

get_date() { date '+%R %d/%m/%Y'; }

update_bar() {
  vol="$(get_volume)"
  bat="$(get_battery)"
  wifi="$(get_wifi)"
  dat="$(get_date)"
  printf '['
  printf '{"name":"vol","full_text":"%s"},'  "$(j "$vol")"
  printf '{"name":"bat","full_text":"%s"},'  "$(j "$bat")"
  printf '{"name":"wifi","full_text":"%s"},' "$(j "$wifi")"
  printf '{"name":"date","full_text":"%s"}'  "$(j "$dat")"
  printf ']\n'
}

printf '{"version":1}\n[\n'
echo $$ >"$PIDFILE"

trap ':' USR1

comma=""
while :; do
  printf '%s' "$comma"
  update_bar
  comma=","
  sleep 2 &
  wait $! 2>/dev/null || true
done
