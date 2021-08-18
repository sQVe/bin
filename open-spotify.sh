#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ┏━┓┏━┓┏━┓╺┳╸╻┏━╸╻ ╻
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┗━┓┣━┛┃ ┃ ┃ ┃┣╸ ┗┳┛
#  ┗━┛╹  ┗━╸╹ ╹   ┗━┛╹  ┗━┛ ╹ ╹╹   ╹

current_dpi=$(rg 'Xft.dpi' "$DOTFILES/config/Xresources" | rg -o '\d+')

if ! pgrep spotify; then
  i3-msg workspace "6  "
fi

if [[ $current_dpi -gt 96 ]]; then
  spotify --force-device-scale-factor=1.7 %U
else
  spotify %U
fi
