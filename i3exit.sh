#!/usr/bin/env bash

case "$1" in
    exit)
        pkill xss-lock & pkill redshift & i3-msg exit
        ;;
    hibernate)
        systemctl hibernate
        ;;
    lock)
        lock
        ;;
    reboot)
        systemctl reboot
        ;;
    suspend)
        systemctl suspend
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 { exit | hibernate | lock | reboot | suspend | shutdown }"
        exit 2
esac
exit 0
