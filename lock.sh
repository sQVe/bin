#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

(sleep 30s && xset dpms force standby) &
dpms_standby=$!

(sleep 30m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause
i3lock -n -c 22093F
kill $dpms_standby
kill $gpg_clear
