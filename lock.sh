#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

(sleep 1m && xset dpms force standby) &
dpms_standby=$!

(sleep 15m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause &

notify-send "DUNST_COMMAND_PAUSE"
i3lock -n -c 3c3836
notify-send "DUNST_COMMAND_RESUME"

kill $dpms_standby
kill $gpg_clear
