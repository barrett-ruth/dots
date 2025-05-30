#!/bin/sh

get_volume() {
  vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ print $5 }')
  vol="${vol%?}"
  [ "$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')" = 'yes' ] && muted=!
  vol=" ${vol:-n/a}$muted"
  echo "$vol"
}

get_battery() {
  STATE_FILE="$XDG_STATE_HOME/.battery_notify_state"
  filler_icon='/usr/share/icons/Adwaita/16x16/status/airplane-mode-symbolic.symbolic.png'

  bat="$(cat /sys/class/power_supply/BAT0/capacity)"
  status="$(cat /sys/class/power_supply/BAT0/status)"
  status_symbol=-
  [ "$status" = "Charging" ] && status_symbol=+
  [ "$status" = "Full" ] && status_symbol=

  if [ "$status" = "Discharging" ]; then
    if [ "$bat" -eq 30 ] && ! grep -q "^30$" "$STATE_FILE" 2>/dev/null; then
      notify-send --urgency normal -i "$filler_icon" "Battery at 30%"
      echo 30 >"$STATE_FILE"
    fi

    if [ "$bat" -eq 15 ] && ! grep -q "^15$" "$STATE_FILE" 2>/dev/null; then
      notify-send --urgency critical -i "$filler_icon" "Battery at 15%"
      echo 15 >"$STATE_FILE"
    fi
  else
    true >"$STATE_FILE" 2>/dev/null
  fi

  [ -n "$bat" ] && echo "$status_symbol$bat%"
}

get_wifi() {
  station="$(iwctl station list | rg ' connected' | awk '{ print $2 }')"
  if [ -n "$station" ]; then
    station_info="$(iwctl station "$station" show)"
    ssid="$(echo "${station_info#*Connected network}" | head -n 1 | xargs)"
  fi
  ssid="${ssid:-n/a}"
  echo "$ssid"
}

get_date() {
  date '+%R | %a %d/%m/%Y'
}

while :; do
  echo "$(get_volume) | $(get_battery) | $(get_wifi) | $(get_date)"
  sleep 1
done
