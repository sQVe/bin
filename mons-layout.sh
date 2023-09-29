#!/usr/bin/env bash

#  ┏┳┓┏━┓┏┓╻┏━┓   ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸
#  ┃┃┃┃ ┃┃┗┫┗━┓   ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃
#  ╹ ╹┗━┛╹ ╹┗━┛   ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹

if [[ $(envycontrol --query) == "nvidia" ]]; then
  case "$1" in
    mancave)
      xrandr \
        --output eDP-1-1 --mode 2560x1600 --pos 2560x0 --rotate normal \
        --output DP-1-1-2 --mode 2560x1440 --pos 0x0 --rotate inverted --primary \
        --output DP-1-1-3 --mode 2560x1440 --pos 0x1440 --rotate normal \
        --output DP-0 --off \
        --output DP-1 --off \
        --output DP-1-1 --off \
        --output DP-1-1-1 --off \
        --output DP-1-2 --off \
        --output DP-1-3 --off \
        --output DP-2 --off \
        --output HDMI-0 --off \
        --output HDMI-1-1 --off \
        --output HDMI-1-2 --off \
        --output HDMI-1-3 --off
      ;;
  esac
else
  case "$1" in
    mancave)
      xrandr \
        --output eDP-1 --mode 2560x1600 --pos 2560x0 --rotate normal \
        --output DP-1-2 --mode 2560x1440 --pos 0x0 --rotate inverted --primary \
        --output DP-1-3 --mode 2560x1440 --pos 0x1440 --rotate normal \
        --output DP-1 --off \
        --output DP-1-1 --off \
        --output DP-2 --off \
        --output DP-3 --off \
        --output HDMI-1 --off \
        --output HDMI-2 --off \
        --output HDMI-3 --off
      ;;
  esac
fi

random-wallpaper
