#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ┏━┓┏━┓┏━┓╺┳╸╻┏━╸╻ ╻
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┗━┓┣━┛┃ ┃ ┃ ┃┣╸ ┗┳┛
#  ┗━┛╹  ┗━╸╹ ╹   ┗━┛╹  ┗━┛ ╹ ╹╹   ╹

if ! pgrep spotify; then
  i3-msg workspace "4  "
fi

spotify --force-device-scale-factor=1.7 %U
