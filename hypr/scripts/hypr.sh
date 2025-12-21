#!/bin/sh

usage() {
    cat <<EOF
Usage: hypr.sh <subcommand> <app> [args...]

Subcommands:
  spawnfocus       Focus an existing window of the app or spawn it if not running
  moveto           Move the window of the app to the current workspace and focus it

Options:
  -h, --help       Show this help message
EOF
}

[ -z "$1" ] && { usage; exit 1; }
case "$1" in
  -h|--help) usage; exit 0 ;;
esac

SUBCMD="$1"
shift

[ -z "$1" ] && { echo "Error: no app specified"; usage; exit 1; }
APP="$1"
shift
ARGS="$*"

case "$APP" in
  google-chrome|google-chrome-stable) CLASS="google-chrome" ;;
  chromium|ungoogled-chromium) CLASS="Chromium" ;;
  firefox) CLASS="firefox" ;;
  alacritty) CLASS="Alacritty" ;;
  code|vscodium) CLASS="Code" ;;
  signal-desktop|signal) CLASS="signal" ;;
  telegram-desktop|telegram) CLASS="TelegramDesktop" ;;
  ghostty) CLASS="com.mitchellh.ghostty" ;;
  bitwarden-desktop|bitwarden) CLASS="Bitwarden" ;;
  slack) CLASS="Slack" ;;
  discord) CLASS="discord" ;;
  vesktop) CLASS="vesktop" ;;
  *) CLASS="$APP" ;;
esac

WIN_ADDR=$(hyprctl -j clients 2>/dev/null | jq -r --arg class "$CLASS" '
  .[]? | select(
    ((.xdgTag // "") | ascii_downcase | contains($class | ascii_downcase)) or
    ((.initialClass // "") | ascii_downcase | contains($class | ascii_downcase)) or
    ((.class // "") | ascii_downcase | contains($class | ascii_downcase))
  ) | .address
' | head -n 1)

case "$SUBCMD" in
  spawnfocus)
    if [ -n "$WIN_ADDR" ]; then
      hyprctl dispatch focuswindow "address:$WIN_ADDR"
    else
      "$APP" "$ARGS" &
    fi
    ;;
  moveto)
    if [ -n "$WIN_ADDR" ]; then
      CURRENT_WS="$(hyprctl activeworkspace | head -n1 | awk -F'[()]' '{print $2}')"
      hyprctl dispatch movetoworkspace "$CURRENT_WS,address:$WIN_ADDR"
      # hyprctl dispatch focuswindow "address:$WIN_ADDR"
    else
      echo "No running window of class '$CLASS' found to move"
      exit 1
    fi
    ;;
  *)
    echo "Unknown subcommand: $SUBCMD"
    usage
    exit 1
    ;;
esac
