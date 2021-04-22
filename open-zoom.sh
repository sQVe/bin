#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ╺━┓┏━┓┏━┓┏┳┓
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┏━┛┃ ┃┃ ┃┃┃┃
#  ┗━┛╹  ┗━╸╹ ╹   ┗━╸┗━┛┗━┛╹ ╹

id=$(rg -o '\d+$' <<< "$1")

if [[ -n "$id" ]]; then
  mimeo "zoommtg://zoom.us/join?confno=$id"
fi
