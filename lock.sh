#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

command playerctl pause
command i3lock -c 22093F
command gpg-connect-agent reloadagent /bye

sleep 30 && \
  command pgrep i3lock && \
  command xset dpms force standby
