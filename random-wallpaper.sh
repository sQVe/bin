#!/usr/bin/env bash

#  ┏━┓┏━┓┏┓╻╺┳┓┏━┓┏┳┓   ╻ ╻┏━┓╻  ╻  ┏━┓┏━┓┏━┓┏━╸┏━┓
#  ┣┳┛┣━┫┃┗┫ ┃┃┃ ┃┃┃┃   ┃╻┃┣━┫┃  ┃  ┣━┛┣━┫┣━┛┣╸ ┣┳┛
#  ╹┗╸╹ ╹╹ ╹╺┻┛┗━┛╹ ╹   ┗┻┛╹ ╹┗━╸┗━╸╹  ╹ ╹╹  ┗━╸╹┗╸

function get_random_directory() {
  fd . --type directory --max-depth 1 "$1" | shuf -n 1
}

work=$(get_random_directory "$PICTURES/art/simon-stålenhag")
[[ -n "$work" ]] && feh --randomize --bg-fill --no-fehbg "$work"/*
