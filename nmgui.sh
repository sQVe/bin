#!/usr/bin/env bash

#  ┏┓╻┏┳┓┏━╸╻ ╻╻
#  ┃┗┫┃┃┃┃╺┓┃ ┃┃
#  ╹ ╹╹ ╹┗━┛┗━┛╹

(nm-applet) &
nm_applet_background=$!

stalonetray --background "#282828" > /dev/null 2>&1
kill $nm_applet_background
