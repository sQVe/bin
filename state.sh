#!/usr/bin/env bash

#  ┏━┓╺┳╸┏━┓╺┳╸┏━╸
#  ┗━┓ ┃ ┣━┫ ┃ ┣╸
#  ┗━┛ ╹ ╹ ╹ ╹ ┗━╸

case "$1" in
exit)
  "$SCRIPTS/backup-shell-history.sh"
  i3-msg exit
  ;;
lock)
  lock
  ;;
shutdown | poweroff)
  "$SCRIPTS/backup-shell-history.sh"
  systemctl poweroff
  ;;
suspend)
  systemctl suspend
  ;;
reboot)
  "$SCRIPTS/backup-shell-history.sh"
  systemctl reboot
  ;;
esac
