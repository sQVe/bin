#!/usr/bin/env bash

#  ┏┳┓┏━┓┏┓╻┏━┓   ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸
#  ┃┃┃┃ ┃┃┗┫┗━┓   ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃
#  ╹ ╹┗━┛╹ ╹┗━┛   ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹

gpu_mode=$(envycontrol --query)

case "$1" in
  mancave)
    case "$2" in
      office)
        if [[ "${gpu_mode}" == 'integrated' ]]; then
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
        else
          notify-send "Unable to load to mancave office layout, switch to integrated GPU."
        fi
        ;;
      gaming)
        if [[ "${gpu_mode}" == 'nvidia' ]]; then
          # TODO: Apply saved xrandr layout.
          echo "gaming"
        else
          notify-send "Unable to load to mancave gaming layout, switch to dedicated GPU."
        fi
        ;;
      tv)
        if [[ "${gpu_mode}" == 'nvidia' ]]; then
          # TODO: Apply saved xrandr layout.
          echo "tv"
        else
          notify-send "Unable to load to mancave tv layout, switch to dedicated GPU."
        fi
        ;;
    esac
    ;;
  hups)
    if [[ "${gpu_mode}" == 'nvidia' ]]; then
      xrandr \
        --output DP-0 --mode 3840x1600 --pos 0x0 --rotate normal --primary \
        --output DP-1 --off \
        --output DP-1-1 --off \
        --output DP-1-2 --off \
        --output DP-1-3 --off \
        --output DP-2 --off \
        --output HDMI-0 --off \
        --output HDMI-1-1 --off \
        --output HDMI-1-2 --off \
        --output HDMI-1-3 --off \
        --output eDP-1-1 --off
    else
      notify-send "Unable to load to hups layout, switch to dedicated GPU."
    fi
    ;;
esac

random-wallpaper
