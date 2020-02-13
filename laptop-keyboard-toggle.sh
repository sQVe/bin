#!/usr/bin/env bash

#  ╻  ┏━┓┏━┓╺┳╸┏━┓┏━┓   ╻┏ ┏━╸╻ ╻┏┓ ┏━┓┏━┓┏━┓╺┳┓   ╺┳╸┏━┓┏━╸┏━╸╻  ┏━╸
#  ┃  ┣━┫┣━┛ ┃ ┃ ┃┣━┛   ┣┻┓┣╸ ┗┳┛┣┻┓┃ ┃┣━┫┣┳┛ ┃┃    ┃ ┃ ┃┃╺┓┃╺┓┃  ┣╸
#  ┗━╸╹ ╹╹   ╹ ┗━┛╹     ╹ ╹┗━╸ ╹ ┗━┛┗━┛╹ ╹╹┗╸╺┻┛    ╹ ┗━┛┗━┛┗━┛┗━╸┗━╸

keyboard_name="AT Translated Set 2 keyboard"

if xinput list "$keyboard_name" | rg --quiet "disabled"; then
  xinput enable "$keyboard_name"
else
  xinput disable "$keyboard_name"
fi
