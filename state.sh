#!/usr/bin/env bash

#  ┏━┓╺┳╸┏━┓╺┳╸┏━╸
#  ┗━┓ ┃ ┣━┫ ┃ ┣╸
#  ┗━┛ ╹ ╹ ╹ ╹ ┗━╸

set -euo pipefail

backup_history() {
  "${SCRIPTS}/zsh/backup-history.sh"
}

case "${1:-}" in
  exit)
    backup_history
    niri msg action quit
    ;;
  lock)
    qs msg -c noctalia-shell lockScreen lock
    ;;
  shutdown | poweroff)
    backup_history
    systemctl poweroff
    ;;
  suspend)
    systemctl suspend
    ;;
  reboot)
    backup_history
    systemctl reboot
    ;;
  *)
    echo "Usage: $(basename "$0") {exit|lock|shutdown|poweroff|suspend|reboot}" >&2
    exit 1
    ;;
esac
