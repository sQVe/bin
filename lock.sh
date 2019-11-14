#!/usr/bin/env bash

#  ╻  ┏━┓┏━╸╻┏
#  ┃  ┃ ┃┃  ┣┻┓
#  ┗━╸┗━┛┗━╸╹ ╹

(sleep 1m && xset dpms force standby) &
dpms_standby=$!

(sleep 15m && pkill greenclip && greenclip clear && greenclip daemon) &
clipboard_clear=$!

(sleep 30m && gpg-connect-agent reloadagent /bye) &
gpg_clear=$!

playerctl pause &
i3lock -n -c 3c3836

kill $dpms_standby
kill $clipboard_clear
kill $gpg_clear
