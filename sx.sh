#!/usr/bin/env bash

#  ┏━┓╻ ╻
#  ┗━┓┏╋┛
#  ┗━┛╹ ╹

readonly xresources="${DOTFILES}/config/Xresources"
default_dpi=$(xrdb -query | awk '/Xft.dpi/ {print $2}')

# Ensure Xorg starts in home directory.
cd "${HOME}" || {
  printf "Failed to change directory to HOME.\n"
  exit 1
}

# Touch Xauthority to remove "file not found" outputs.
touch "${XDG_RUNTIME_DIR}/.Xauthority"

if [[ $1 =~ ^-?[0-9]+$ ]]; then
  sed -i "/Xft.dpi/s/${default_dpi}/$1/" "${xresources}"
  printf "Starting the X server with DPI set to %s...\n" "$1"

  # Revert back to the default DPI setting after a set time.
  (sleep 2 && sed -i "/Xft.dpi/s/$1/${default_dpi}/" "${xresources}") &
else
  printf "Starting the X server with the default DPI setting...\n"
fi

startx
