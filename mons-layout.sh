#!/usr/bin/env bash

#  ┏┳┓┏━┓┏┓╻┏━┓   ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸
#  ┃┃┃┃ ┃┃┗┫┗━┓   ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃
#  ╹ ╹┗━┛╹ ╹┗━┛   ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹

case "$1" in
  home)
    xrandr --output DP-1-2 --off --output DP-1-3 --off
    sleep 3

    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 2560x766 --rotate normal --output DP-1-2 --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1-3 --mode 2560x1440 --pos 0x1440 --rotate normal
    random-wallpaper
    ;;
esac
