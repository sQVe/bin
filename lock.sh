#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

playerctl pause
i3lock -c 22093F
gpg-connect-agent reloadagent /bye

sleep 30 && \
  pgrep i3lock && \
  xset dpms force standby
