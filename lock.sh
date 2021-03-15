#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

(sleep 1m && xset dpms force standby) &
dpms_standby=$!

(sleep 15m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause &

dunstify "DUNST_COMMAND_PAUSE"
xset dpms 30 30 30
pkill xcompmgr

i3lock -e -n -c 3c3836

dunstify "DUNST_COMMAND_RESUME"
xset dpms 240 240 240
xcompmgr &

kill $dpms_standby
kill $gpg_clear
