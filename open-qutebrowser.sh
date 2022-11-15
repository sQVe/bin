#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ┏━┓╻ ╻╺┳╸┏━╸┏┓ ┏━┓┏━┓╻ ╻┏━┓┏━╸┏━┓
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┃┓┃┃ ┃ ┃ ┣╸ ┣┻┓┣┳┛┃ ┃┃╻┃┗━┓┣╸ ┣┳┛
#  ┗━┛╹  ┗━╸╹ ╹   ┗┻┛┗━┛ ╹ ┗━╸┗━┛╹┗╸┗━┛┗┻┛┗━┛┗━╸╹┗╸

current_dpi=$(rg 'Xft.dpi' "${DOTFILES}/config/Xresources" | rg -o '\d+')

if [[ ${current_dpi} -gt 96 ]]; then
  QT_SCALE_FACTOR=2 qutebrowser "$@"
else
  qutebrowser "$@"
fi
