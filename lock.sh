#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

# Exit early when already locked.
pgrep -x i3lock && exit

(sleep 1m && sudo -K) &
sudo_revoke=$!

(sleep 15m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause &

dunstctl set-paused true
pkill xcompmgr

i3lock -e -n -c 3c3836

xset s 240 0
dunstctl set-paused false
xcompmgr -c -l 0 -t 0 -r 0 -o 0 &

kill "${sudo_revoke}"
kill "${gpg_clear}"
