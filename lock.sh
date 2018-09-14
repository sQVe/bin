#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

command playerctl pause
command i3lock -c 22093F

sleep 30 && \
  command pgrep i3lock && \
  command xset dpms force standby
