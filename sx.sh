#!/usr/bin/env bash

#  ┏━┓╻ ╻
#  ┗━┓┏╋┛
#  ┗━┛╹ ╹

if [[ $1 =~ ^-?[0-9]+$ ]]; then
  xresources_path=$HOME/.Xresources
  dpi=$(rg --no-line-number Xft.dpi "$xresources_path" | awk '{print $2}')

  sed -i "/Xft.dpi/s/$dpi/$1/" "$xresources_path"
  echo "Starting the X server with DPI set to $1..."

  # Revert back to the default DPI setting after a set time.
  (sleep 2; sed -i "/Xft.dpi/s/$1/$dpi/" "$xresources_path") & disown
  startx
  exit 0
fi

echo "Starting the X server with the default DPI setting..."
startx
