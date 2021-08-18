#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ┏━┓╻ ╻╺┳╸┏━╸┏┓ ┏━┓┏━┓╻ ╻┏━┓┏━╸┏━┓
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┃┓┃┃ ┃ ┃ ┣╸ ┣┻┓┣┳┛┃ ┃┃╻┃┗━┓┣╸ ┣┳┛
#  ┗━┛╹  ┗━╸╹ ╹   ┗┻┛┗━┛ ╹ ┗━╸┗━┛╹┗╸┗━┛┗┻┛┗━┛┗━╸╹┗╸

current_dpi=$(rg 'Xft.dpi' "$DOTFILES/config/Xresources" | rg -o '\d+')

if ! pgrep qutebrowser; then
  i3-msg workspace "2  "
fi

if [[ $current_dpi -gt 96 ]]; then
  QT_SCALE_FACTOR=2 qutebrowser "$@"
else
  qutebrowser "$@"
fi
