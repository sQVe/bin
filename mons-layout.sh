#!/usr/bin/env bash

#  ┏┳┓┏━┓┏┓╻┏━┓   ╻  ┏━┓╻ ╻┏━┓╻ ╻╺┳╸
#  ┃┃┃┃ ┃┃┗┫┗━┓   ┃  ┣━┫┗┳┛┃ ┃┃ ┃ ┃
#  ╹ ╹┗━┛╹ ╹┗━┛   ┗━╸╹ ╹ ╹ ┗━┛┗━┛ ╹

vga_controllers=$(lspci -v | rg "VGA controller")

if [[ $(echo "${vga_controllers}" | wc -l) == '2' ]]; then
  gpu_mode="hGPU"
else
  if echo "${vga_controllers}" | rg 'NVIDIA' &> /dev/null; then
    gpu_mode="dGPU"
  else
    gpu_mode="iGPU"
  fi
fi

case "$1" in
  mancave)
    case "${gpu_mode}" in
      iGPU)
        # TODO: Add xrandr command.
        echo "iGPU"
        ;;
      hGPU)
        # TODO: Add xrandr command.
        echo "hGPU"
        ;;
      *)
        notify-send "Unable to load to mancave layout, switch to integrated GPU."
        ;;
    esac
    ;;
  hups)
    if [[ "${gpu_mode}" == 'dGPU' ]]; then
      xrandr --output DP-0 --mode 3840x1600 --pos 0x0 --rotate normal --primary \
        --output DP-1 --off \
        --output HDMI-0 --off \
        --output DP-2 --off \
        --output None-1-1 --off
    else
      notify-send "Unable to load to hups layout, switch to dedicated GPU."
    fi
    ;;
esac

random-wallpaper
