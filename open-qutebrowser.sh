#!/usr/bin/env bash

#  ┏━┓┏━┓┏━╸┏┓╻   ┏━┓╻ ╻╺┳╸┏━╸┏┓ ┏━┓┏━┓╻ ╻┏━┓┏━╸┏━┓
#  ┃ ┃┣━┛┣╸ ┃┗┫   ┃┓┃┃ ┃ ┃ ┣╸ ┣┻┓┣┳┛┃ ┃┃╻┃┗━┓┣╸ ┣┳┛
#  ┗━┛╹  ┗━╸╹ ╹   ┗┻┛┗━┛ ╹ ┗━╸┗━┛╹┗╸┗━┛┗┻┛┗━┛┗━╸╹┗╸

if ! pgrep qutebrowser; then
  i3-msg workspace "3  "
fi

QT_SCALE_FACTOR=2 qutebrowser "$@"
