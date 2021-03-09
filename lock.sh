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
pkill xcompmgr

i3lock -n -c 3c3836

dunstify "DUNST_COMMAND_RESUME"
xcompmgr -C &

kill $dpms_standby
kill $gpg_clear
