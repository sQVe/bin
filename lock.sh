#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

# Exit early when already locked.
pgrep -x i3lock && exit

(sleep 1m && xset dpms force standby) &
dpms_standby=$!

(sleep 1m && sudo -K) &
sudo_revoke=$!

(sleep 15m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause &

dunstctl set-paused true
xset dpms 30 30 30
pkill xcompmgr

i3lock -e -n -c 3c3836

dunstctl set-paused false
xset dpms 240 240 240
xcompmgr -c -l 0 -t 0 -r 0 -o 0 &

kill "${dpms_standby}"
kill "${sudo_revoke}"
kill "${gpg_clear}"
