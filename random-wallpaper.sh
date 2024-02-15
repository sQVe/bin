#!/usr/bin/env bash

#  ┏━┓┏━┓┏┓╻╺┳┓┏━┓┏┳┓   ╻ ╻┏━┓╻  ╻  ┏━┓┏━┓┏━┓┏━╸┏━┓
#  ┣┳┛┣━┫┃┗┫ ┃┃┃ ┃┃┃┃   ┃╻┃┣━┫┃  ┃  ┣━┛┣━┫┣━┛┣╸ ┣┳┛
#  ╹┗╸╹ ╹╹ ╹╺┻┛┗━┛╹ ╹   ┗┻┛╹ ╹┗━╸┗━╸╹  ╹ ╹╹  ┗━╸╹┗╸

function get_random_directory() {
  fd . --type directory --max-depth 1 "$1" | shuf -n 1
}

source=$(get_random_directory "$PICTURES/wallpapers")
random_category=$(get_random_directory "$source")

[[ -n "$random_category" ]] && feh --randomize --bg-fill --no-fehbg "$random_category"/*
