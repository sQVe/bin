#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

command playerctl pause
command i3lock -c 2F0D59

sleep 30 && \
  command pgrep i3lock && \
  command xset dpms force off
