#!/usr/bin/env bash

#  ┏━┓╻ ╻
#  ┗━┓┏╋┛
#  ┗━┛╹ ╹

# Ensure Xorg starts in home directory.
cd "$HOME" || exit

# Touch Xauthority to remove "file not found" outputs.
touch "$XDG_RUNTIME_DIR/Xauthority"

if [[ $1 =~ ^-?[0-9]+$ ]]; then
  xresources=$DOTFILES/config/Xresources
  dpi=$(rg --no-line-number Xft.dpi "$xresources" | awk '{print $2}')

  sed -i "/Xft.dpi/s/$dpi/$1/" "$xresources"
  echo "Starting the X server with DPI set to $1..."

  # Revert back to the default DPI setting after a set time.
  (sleep 2 && sed -i "/Xft.dpi/s/$1/$dpi/" "$xresources") &

  startx
  exit 0
fi

echo "Starting the X server with the default DPI setting..."
startx
