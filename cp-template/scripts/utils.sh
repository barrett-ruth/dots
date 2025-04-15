#!/bin/sh

execute_binary() {
  binary="$1"
  input="$2"
  output="$3"

  start=$(date '+%s.%N')
  timeout 2s ./"$binary" <"$input" >"$output" 2>&1
  CODE=$?
  end=$(date '+%s.%N')
  truncate -s "$(head -n 1000 "$output" | wc -c)" "$output"

  if [ $CODE -ge 124 ]; then
    MSG=''
    case $CODE in
    124) MSG='TIMEOUT' ;;
    128) MSG='SIGILL' ;;
    130) MSG='SIGABRT' ;;
    131) MSG='SIGBUS' ;;
    136) MSG='SIGFPE' ;;
    135) MSG='SIGSEGV' ;;
    137) MSG='SIGPIPE' ;;
    139) MSG='SIGTERM' ;;
    esac
    [ $CODE -ne 124 ] && sed -i '$d' "$output"
    test -n "$MSG" && printf '\n[code]: %s (%s)' "$CODE" "$MSG" >>"$output"
  else
    printf '\n[code]: %s' "$CODE" >>"$output"
  fi

  printf '\n[time]: %s ms' "$(awk "BEGIN {print ($end - $start) * 1000}")" >>$output
  return $CODE
}

compile_source() {
  src="$1"
  bin="$2"
  output="$3"
  flags="$4"

  test -f "$bin" && rm "$bin" || true
  g++ @compile_flags.txt $flags "$src" -o "$bin" 2>"$output"
  CODE=$?

  if [ $CODE -gt 0 ]; then
    printf '\n[code]: %s' "$CODE" >>"$output"
    return $CODE
  else
    echo '' >"$output"
    return 0
  fi
}
