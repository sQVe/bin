#!/usr/bin/env bash

#  ┏┳┓┏━┓┏┓╻┏━┓   ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸
#  ┃┃┃┃ ┃┃┗┫┗━┓   ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃
#  ╹ ╹┗━┛╹ ╹┗━┛   ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹

case "$1" in
  home)
    xrandr --output DP-1-2 --off --output DP-1-3 --off
    sleep 3
    xrandr --output eDP-1 --mode 1920x1080 --pos 2560x561 --rotate normal --output DP-1-2 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1-3 --mode 2560x1440 --pos 0x1440 --rotate normal
    random-wallpaper
    ;;
esac
