#!/usr/bin/env bash

if [[ $1 =~ ^-?[0-9]+$ ]]; then
  xresources=$HOME/.Xresources
  default_dpi=$(ag --nonumbers Xft.dpi "$xresources" | awk '{print $2}')

  sed -i "/Xft.dpi/s/$default_dpi/$1/" "$xresources"
  echo "Starting the X server with DPI set to $1..."
  startx
  sed -i "/Xft.dpi/s/$1/$default_dpi/" "$xresources"
  exit 0
fi

echo "Starting the X server with the default DPI setting..."
startx
