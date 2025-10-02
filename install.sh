#!/usr/bin/env bash

#  ╻┏┓╻┏━┓╺┳╸┏━┓╻  ╻
#  ┃┃┗┫┗━┓ ┃ ┣━┫┃  ┃
#  ╹╹ ╹┗━┛ ╹ ╹ ╹┗━╸┗━╸

actual_user="${SUDO_USER:-$USER}"
local_binaries="/usr/local/bin"

if [ ! -w "$local_binaries" ]; then
  echo "Error: Cannot write to $local_binaries. Run with sudo." >&2
  exit 1
fi

ln -sf "/home/${actual_user}/.bin/dots.sh" "${local_binaries}/dots"
ln -sf "/home/${actual_user}/.bin/far.sh" "${local_binaries}/far"
ln -sf "/home/${actual_user}/.bin/ghc.sh" "${local_binaries}/ghc"
ln -sf "/home/${actual_user}/.bin/laptop-keyboard-toggle.sh" "${local_binaries}/laptop-keyboard-toggle"
ln -sf "/home/${actual_user}/.bin/lock.sh" "${local_binaries}/lock"
ln -sf "/home/${actual_user}/.bin/mount-shishigami.sh" "${local_binaries}/mount-shishigami"
ln -sf "/home/${actual_user}/.bin/nmgui.sh" "${local_binaries}/nmgui"
ln -sf "/home/${actual_user}/.bin/note.sh" "${local_binaries}/note"
ln -sf "/home/${actual_user}/.bin/nvim-dir.sh" "${local_binaries}/nvim-dir"
ln -sf "/home/${actual_user}/.bin/open-helium.sh" "${local_binaries}/open-helium"
ln -sf "/home/${actual_user}/.bin/open-qutebrowser.sh" "${local_binaries}/open-qutebrowser"
ln -sf "/home/${actual_user}/.bin/open-slack.sh" "${local_binaries}/open-slack"
ln -sf "/home/${actual_user}/.bin/open-spotify.sh" "${local_binaries}/open-spotify"
ln -sf "/home/${actual_user}/.bin/open-steam.sh" "${local_binaries}/open-steam"
ln -sf "/home/${actual_user}/.bin/open.sh" "${local_binaries}/open"
ln -sf "/home/${actual_user}/.bin/random-wallpaper.sh" "${local_binaries}/random-wallpaper"
ln -sf "/home/${actual_user}/.bin/repos-behind.sh" "${local_binaries}/repos-behind"
ln -sf "/home/${actual_user}/.bin/repos-dirty.sh" "${local_binaries}/repos-dirty"
ln -sf "/home/${actual_user}/.bin/root.sh" "${local_binaries}/root"
ln -sf "/home/${actual_user}/.bin/save-notes.sh" "${local_binaries}/save-notes"
ln -sf "/home/${actual_user}/.bin/state.sh" "${local_binaries}/state"
ln -sf "/home/${actual_user}/.bin/sx.sh" "${local_binaries}/sx"
ln -sf "/home/${actual_user}/.bin/term.sh" "${local_binaries}/term"
ln -sf "/home/${actual_user}/.bin/wallpaper.sh" "${local_binaries}/wallpaper"
